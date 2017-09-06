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
    post "register", RegistrationController, :create
    post "token", SessionController, :create, as: :login
  end
end
