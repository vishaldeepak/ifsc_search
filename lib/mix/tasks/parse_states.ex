defmodule Mix.Tasks.ParseStates do
  @moduledoc """
  Given data in xlsx sheets fetch State Information

  mix parse_states
  """
    use Mix.Task
    require Logger
    require IEx

    alias IndiaInfo.Locations
    alias IndiaInfo.Locations.State
    alias IndiaInfo.Repo

    @shortdoc "Parse States along with short form"

    @map_sheet %{name: 0, code: 1}

    def run(_args) do
      Mix.Task.run "app.start"

      total_rows = process_file "./build_data/indian_states.xlsx"
      IO.puts "Total No of rows processed- #{total_rows}"
      IO.puts "Total No of States is db currently -" <> to_string (Repo.aggregate(State, :count, :id))
    end

    defp process_file file do
      IO.puts "processing #{file}"
      {:ok, table_id} = Xlsxir.multi_extract(file, 0)
      row_count = Xlsxir.get_multi_info(table_id, :rows)

      # IEx.pry
      table_id
      |> Xlsxir.get_list()
      |> Enum.drop(1)
      |> Enum.each(&process_row/1)

      Xlsxir.close(table_id)
      row_count - 1
    end

    defp process_row row do
      try do
        state_info = %{name: Enum.fetch!(row, @map_sheet[:name]), code: Enum.fetch!(row, @map_sheet[:code])}
        Locations.create_state(state_info)
      rescue
         e -> Logger.error "Error in process_row" <> e.message
      end
    end
  end