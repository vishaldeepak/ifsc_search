defmodule Mix.Tasks.ParseIfsc do
  use Mix.Task
  require IEx
  
  @shortdoc "Parse IFSC codes" 

  def run(_args) do
    Mix.Task.run "app.start"
    # Exoffice.parse("./build_data/IFCB2009_03.xlsx")
    IEx.pry
    # Exoffice.parse("./test/test_data/test.xls")
  end

end