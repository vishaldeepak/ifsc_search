defmodule IndiaInfoWeb.DistrictView do
use IndiaInfoWeb, :view

  def render("get_districts_from_state.json", %{districts: districts}) do
    %{
      branches: Enum.map(districts, &district_json/1)
    }
  end

  defp district_json(district) do
    %{
      name: district.name,
      id: district.id
    }
  end
end