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

  pipeline :valid_login do
    plug MrbeekenBackendWeb.ValidLogin
  end

  scope "/api/v1", MrbeekenBackendWeb do
    pipe_through [:api, :auth]

    get "/dummy", DummyController, :show
    resources "/users", UserController, only: [:show, :index]
  end

  scope "/api/v1", MrbeekenBackendWeb do
    pipe_through :api

    post "/sessions/logout", SessionsController, :logout
    resources "/users", UserController, only: [:create]
  end

  scope "/api/v1", MrbeekenBackendWeb do
    pipe_through [:api, :valid_login]

    post "/sessions/login", SessionsController, :login
  end
end
