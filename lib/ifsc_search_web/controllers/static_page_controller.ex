defmodule IfscSearchWeb.StaticPageController do
  use IfscSearchWeb, :controller
  alias IfscSearch.Banks

  def about(conn, _params) do
    bank_count = Banks.get_bank_count
    branch_count = Banks.get_branch_count
    render(conn, "about.html", bank_count: bank_count, branch_count: branch_count)
  end

  def ifsc_about(conn, _params) do
    render(conn, "ifsc_about.html")
  end
end
