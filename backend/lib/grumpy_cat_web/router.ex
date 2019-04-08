defmodule GrumpyCatWeb.Router do
  use GrumpyCatWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api", GrumpyCatWeb do
    pipe_through :api

    resources "/companies", CompanyController
  end
end
