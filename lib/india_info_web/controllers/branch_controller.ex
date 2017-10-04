defmodule IndiaInfoWeb.BranchController do
  use IndiaInfoWeb, :controller
  alias IndiaInfo.Locations

  def branch_search(conn, params) do
    states = Locations.list_states([:name, :id])
    render(conn, "branch_search.html", states: states)
  end
end