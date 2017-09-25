defmodule Mix.Tasks.ParseIfsc do
  use Mix.Task
  require IEx

  alias IndiaInfo.Locations
  alias IndiaInfo.Banks
  
  @shortdoc "Parse IFSC codes" 

  @map_sheet %{bank: 0, ifsc: 1, branch: 3, address: 4, contact_no: 5, city: 6, district: 7, state: 8}

  def run(_args) do
    Mix.Task.run "app.start"
    start_location = "./build_data/IFSC_data"

    Enum.each(File.ls!(start_location), fn file -> 
      if Regex.match?(~r/.+\.xlsx$/, file) do
        filename = "#{start_location}/#{file}"
        spawn fn -> process_file(filename) end
      end
    end)
  end

  defp process_file(file) do
    IO.puts "processing #{file}"
    {:ok, table_id} = Xlsxir.multi_extract(file, 0)
    
    Xlsxir.get_list(table_id)
    |> Enum.drop(1)
    |> Enum.each(&process_row/1)
    
    Xlsxir.close(table_id)
  end

  defp process_row row do 
    # IEx.pry
    try do
      {:ok ,state} = Locations.find_or_create_state_by_name(row |> Enum.fetch!(@map_sheet[:state]))
      {:ok ,district} = Locations.find_or_create_district_by_name(row |> Enum.fetch!(@map_sheet[:district]), state.id)
      {:ok ,city} = Locations.find_or_create_city_by_name(row |> Enum.fetch!(@map_sheet[:city]), district.id)
      {:ok, bank} = Banks.find_or_create_bank_by_name row |> Enum.fetch!(@map_sheet[:bank])
      
      case Banks.get_branch_by_ifsc(row |> Enum.fetch!(@map_sheet[:ifsc])) do
        nil ->
          Banks.create_branch(%{bank_id: bank.id, 
          city_id: city.id, 
          name: row |> Enum.fetch!(@map_sheet[:branch]),
          ifsc: row |> Enum.fetch!(@map_sheet[:ifsc]),
          contact_no: row |> Enum.fetch!(@map_sheet[:contact_no]) |> to_string,
          address: row |> Enum.fetch!(@map_sheet[:address])
          })
        _ -> nil
      end

    rescue
      e -> IO.puts e.message
      Logger.error "Exception parse IFSC Task - #{e.message}"
    end
  end
end