defmodule MrbeekenBackendWeb.Router do
  use MrbeekenBackendWeb, :router

  pipeline :api do
    plug CORSPlug, [origin: "http://localhost:4200"]
    plug :accepts, ["json-api"]
    plug JaSerializer.ContentTypeNegotiation
    plug JaSerializer.Deserializer
  end

  pipeline :auth do
    plug MrbeekenBackendWeb.Authentication, repo: MrbeekenBackend.Repo
  end

  scope "/api/v1", MrbeekenBackendWeb do
    pipe_through [:api, :auth]

    get "/dummy", DummyController, :show
    resources "/users", UserController, only: [:show]
  end

  scope "/api/v1", MrbeekenBackendWeb do
    pipe_through :api

    post "/sessions/logout", SessionsController, :logout
    post "/sessions/login", SessionsController, :login
  end
end
