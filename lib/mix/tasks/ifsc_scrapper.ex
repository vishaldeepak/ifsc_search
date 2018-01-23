defmodule Mix.Tasks.IfscScrapper do
  @moduledoc """
  Scrape Data from RBI for IFSC files

  mix parse_ifsc
  """
  use Mix.Task
  require IEx

  @build_dir "build_data"
  @ifsc_dir "IFSC_data"

  def run(_args) do
    if !File.dir?(@build_dir) do
      File.mkdir(@build_dir)
    end
    File.cd(@build_dir)

    if !File.dir?(@ifsc_dir) do
      File.mkdir(@ifsc_dir)
    end
    File.cd(@ifsc_dir)

    HTTPoison.start
    HTTPoison.get!('https://www.rbi.org.in/scripts/bs_viewcontent.aspx?Id=2009').body
    |> Floki.find("#example-min table table td:nth-child(2) a")
    |> Enum.each(fn(attribute) ->
      {_ , [{"href", link}], _name} = attribute

      download_link = URI.parse(link)
        |> Map.put(:scheme, "https")
        |> URI.to_string

      filename = download_link
        |> String.split("/")
        |> List.last()

      downloaded_file = HTTPoison.get!(download_link).body
      File.write(filename, downloaded_file)
      IO.puts "Downloaded file " <> filename
      end)
  end

end