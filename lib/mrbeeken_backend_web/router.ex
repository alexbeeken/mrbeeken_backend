defmodule MrbeekenBackendWeb.Router do
  use MrbeekenBackendWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json", "json-api"]
    plug JaSerializer.ContentTypeNegotiation
    plug JaSerializer.Deserializer
  end

  scope "/", MrbeekenBackendWeb do
    pipe_through :browser # Use the default browser stack

    get "/", PageController, :index
  end

  scope "/api/v1", MrbeekenBackendWeb do
    pipe_through :api

    get "/users", UserController, :index
  end

  # Other scopes may use custom stacks.
  # scope "/api", MrbeekenBackendWeb do
  #   pipe_through :api
  # end
end
