defmodule IndiaInfoWeb.BranchView do
  use IndiaInfoWeb, :view

  def render("branch_search.json", %{branches: branches}) do
    %{
      branches: Enum.map(branches, &branch_json/1)
    }
  end

  defp branch_json(branch) do
    %{
      name: branch.name,
      ifsc: branch.ifsc
    }
  end
end
