defmodule IndiaInfoWeb.BranchController do
  use IndiaInfoWeb, :controller
  alias IndiaInfo.Locations
  alias IndiaInfo.Banks

  def branch_search(conn, %{"state_id" => state_id, "bank_id" => bank_id, "search_term" => search_term}) do
    results = Banks.branch_search(bank_id, search_term, state_id)
    render(conn, "branch_search.js", branches: results)
  end

  def branch_search(conn, _params) do
    states = Locations.list_states([:name, :id])
    banks = Banks.list_banks([:name, :id])
    render(conn, "branch_search.html", states: states, banks: banks)
  end
end