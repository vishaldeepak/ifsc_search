defmodule IfscSearchWeb.DistrictController do
  use IfscSearchWeb, :controller
  alias IfscSearch.Locations

  def get_districts_from_state(conn, %{"state_id" => state_id}) do
    districts = Locations.get_districts_from_state(state_id)
    render(conn, "get_districts_from_state.json", districts: districts)
  end
end
