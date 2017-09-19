defmodule IndiaInfoWeb.PageController do
  use IndiaInfoWeb, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end
end
