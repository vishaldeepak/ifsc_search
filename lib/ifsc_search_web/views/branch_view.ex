defmodule IfscSearchWeb.BranchView do
  use IfscSearchWeb, :view

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

  def set_contact_no(contact_no) do
    case contact_no do
      "0" -> "Unknown"
      _ -> contact_no
    end
  end
end
