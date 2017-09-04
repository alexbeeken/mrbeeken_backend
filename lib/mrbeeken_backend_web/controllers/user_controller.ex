defmodule MrbeekenBackendWeb.UserController do
  use MrbeekenBackendWeb, :controller
  alias MrbeekenBackend.Repo

  def index(conn, _params) do
    users = Repo.all(MrbeekenBackendWeb.User)
    render conn, users: users
  end
end
