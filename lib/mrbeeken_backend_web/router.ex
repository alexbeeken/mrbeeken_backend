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
    post "/sessions/logout", SessionsController, :delete
    post "/sessions/login", SessionsController, :token
    get "/dummy", DummyController, :show

    resources "/users", UserController, only: [:show]
  end
end
