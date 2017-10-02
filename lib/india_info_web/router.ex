defmodule IndiaInfoWeb.Router do
  use IndiaInfoWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", IndiaInfoWeb do
    pipe_through :browser # Use the default browser stack

    get "/", PageController, :index
    get "/ifsc_search", BankController, :branch_search
    resources "/banks", BankController


    resources "/states", StateController

  end

  # Other scopes may use custom stacks.
  # scope "/api", IndiaInfoWeb do
  #   pipe_through :api
  # end
end
