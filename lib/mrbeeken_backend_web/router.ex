defmodule MrbeekenBackendWeb.Router do
  use MrbeekenBackendWeb, :router

  pipeline :api do
    plug CORSPlug, [origin: "http://localhost:4200"]
    plug :accepts, ["json-api"]
    plug JaSerializer.ContentTypeNegotiation
    plug JaSerializer.Deserializer
  end

  pipeline :auth do
    plug MrbeekenBackendWeb.Authentication
  end

  pipeline :valid_login do
    plug MrbeekenBackendWeb.ValidLogin
  end

  pipeline :superuser do
    plug MrbeekenBackendWeb.Superuser
  end

  scope "/api/v1", MrbeekenBackendWeb do
    pipe_through [:api, :auth]

    get "/dummy", DummyController, :show
    get "users/me", UserController, :me
    resources "/users", UserController, only: [:show, :index]
  end

  scope "/api/v1", MrbeekenBackendWeb do
    pipe_through :api

    resources "/posts", PostController, only: [:show, :index]
    get "users/unique/:email", UserController, :unique
    post "/session/logout", SessionController, :logout
    resources "/users", UserController, only: [:create]
  end

  scope "/api/v1", MrbeekenBackendWeb do
    pipe_through [:api, :valid_login]

    post "/session/login", SessionController, :login
  end

  scope "/api/v1", MrbeekenBackendWeb do
    pipe_through [:api, :auth, :superuser]

    get "/dummy/superuser", DummyController, :show, as: :superuser_test
    resources "/posts", PostController, only: [:create, :update, :delete]
  end
end
