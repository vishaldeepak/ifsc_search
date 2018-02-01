defmodule IfscSearchWeb.Router do
  use IfscSearchWeb, :router

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

  scope "/", IfscSearchWeb do
    pipe_through :browser # Use the default browser stack

    post "/get_districts_from_state", DistrictController, :get_districts_from_state

    # get "/", PageController, :index
    get "/", BranchController, :search_index
    post "/ifsc_search", BranchController, :search_branch

    get "/code_search", BranchController, :search_via_code
    post "/code_search", BranchController, :search_via_code

    get "/about", StaticPageController, :about
    get "/whatisifsc", StaticPageController, :ifsc_about

    # post "/locations/districts/by_state", Locations.DistrictController, :by_state

    resources "/branches", BranchController, only: [:show]
    resources "/banks", BankController, except: [:new, :edit, :delete]
    # get "/all_banks", BankController, :all_banks

    resources "/states", StateController, except: [:new, :edit, :delete]
  end

  # Other scopes may use custom stacks.
  # scope "/api", IfscSearchWeb do
  #   pipe_through :api
  # end
end
