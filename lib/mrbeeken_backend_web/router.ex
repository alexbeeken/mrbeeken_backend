defmodule MrbeekenBackendWeb.Router do
  use MrbeekenBackendWeb, :router

  pipeline :api do
    plug CORSPlug, [origin: "http://localhost:4200"]
    plug :accepts, ["json-api"]
    plug JaSerializer.ContentTypeNegotiation
    plug JaSerializer.Deserializer
  end

  scope "/api/v1", MrbeekenBackendWeb do
    pipe_through :api
    post "/sessions/delete", SessionsController, :delete

    resources "/sessions", SessionsController, only: [:create]
    resources "/users", UserController, only: [:show]
  end
end
