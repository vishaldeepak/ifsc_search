defmodule Mix.Tasks.ParseIfsc do
  @moduledoc """
  Given data in xlsx sheets from IFSC.
  Need to run the Task Twice due to race conditions on unqiue constriants

  mix parse_ifsc
  """
    use Mix.Task
    require Logger

    alias IndiaInfo.Locations
    alias IndiaInfo.Banks
    alias IndiaInfo.Banks.Branch
    alias IndiaInfo.Repo

    @shortdoc "Parse IFSC codes"

    @map_sheet %{bank: 0, ifsc: 1, micr: 2, branch: 3, address: 4, contact_no: 5, city: 6, district: 7, state: 8}

    def run(_args) do
      Mix.Task.run "app.start"
      start_location = "./build_data/IFSC_data"

      total_rows =
        start_location
        |> File.ls!
        |> Enum.filter(fn(file) -> Regex.match?(~r/.+\.xlsx$/, file) end)
        |> Enum.map(fn(file) -> "#{start_location}/#{file}"  end)
        |> Enum.reduce(0, &process_file/2)

      IO.puts "Total No of rows processed- #{total_rows}"
      IO.puts "Total No of Branches is db currently -" <> to_string (Repo.aggregate(Branch, :count, :id))
    end

    defp process_file file, total_count do
      IO.puts "processing #{file}"
      {:ok, table_id} = Xlsxir.multi_extract(file, 0)
      row_count = Xlsxir.get_multi_info(table_id, :rows)

      table_id
      |> Xlsxir.get_list()
      |> Enum.drop(1)
      |> Enum.each(fn row -> process_row(row, file) end)

      Xlsxir.close(table_id)

      (row_count - 1) + total_count
    end

    defp process_row row, file do
      try do

        {:ok, state} = Locations.find_state_by_name_or_code(row |> Enum.fetch!(@map_sheet[:state]) |> get_proper_state_name)
        {:ok, district} = Locations.find_or_create_district_by_name(row |> Enum.fetch!(@map_sheet[:district]), state.id)
        {:ok, bank} = Banks.find_or_create_bank_by_name(row |> Enum.fetch!(@map_sheet[:bank]))

        case Banks.get_branch_by_ifsc(row |> Enum.fetch!(@map_sheet[:ifsc])) do
          nil ->
            result = Banks.create_branch(%{bank_id: bank.id,
            district_id: district.id,
            city_name: to_string(@map_sheet[:city]),
            name: row |> Enum.fetch!(@map_sheet[:branch]),
            ifsc: row |> Enum.fetch!(@map_sheet[:ifsc]),
            micr: row |> Enum.fetch!(@map_sheet[:micr]) |> to_string,
            contact_no: row |> Enum.fetch!(@map_sheet[:contact_no]) |> to_string,
            address: row |> Enum.fetch!(@map_sheet[:address])
            })
          _ -> nil
        end
      rescue
         e ->
          Logger.error "Error in process_row " <> file <> "  " <> to_string(Enum.fetch!(row, @map_sheet[:ifsc])) <>  Exception.format(:error, e)
      end
    end

    defp get_proper_state_name state_name do
      case state_name do
        "GREATER MUMBAI" -> "Maharashtra"
        "NEW DELHI" -> "Delhi"
        "KARANATAKA" -> "Karnataka"
        "GUJRAT" -> "Gujarat"
        _ -> state_name
      end
    end
  end