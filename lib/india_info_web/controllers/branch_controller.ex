defmodule IndiaInfoWeb.BranchController do
  use IndiaInfoWeb, :controller
  alias IndiaInfo.Locations
  alias IndiaInfo.Banks

  def search_via_code(conn, %{"code" => code}) do
    branch = Banks.get_branch_by_ifsc(code)
    if is_nil branch do
      conn |> send_resp(404, "not found")
    else
      render(conn, "search_via_code.js", branch: branch)
    end
  end

  def search_via_code(conn, _params) do
    render(conn, "search_via_code.html")
  end

  def show(conn, %{"id" => id}) do
    branch = Banks.get_branch!(id)
    render(conn, "show.html", branch: branch)
  end

  def search_branch(conn, %{"state_id" => state_id, "bank_id" => bank_id, "search_term" => search_term}) do
    results = Banks.branch_search(bank_id, search_term, state_id)
    render(conn, "branch_search.js", branches: results)
  end

  def search_index(conn, _params) do
    states = Locations.list_states([:name, :id])
    banks = Banks.list_banks([:name, :id])
    render(conn, "branch_search.html", states: states, banks: banks)
  end
end