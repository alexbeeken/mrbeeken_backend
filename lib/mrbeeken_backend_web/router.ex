defmodule MrbeekenBackendWeb.Router do
  use MrbeekenBackendWeb, :router

  pipeline :api do
    plug CORSPlug, [origin: "http://localhost:4200"]
    plug :accepts, ["json", "json-api"]
    plug JaSerializer.ContentTypeNegotiation
    plug JaSerializer.Deserializer
  end

  scope "/api/v1", MrbeekenBackendWeb do
    pipe_through :api

    get "/users", UserController, :index
    resources "session", SessionController, only: [:index]
  end
end
