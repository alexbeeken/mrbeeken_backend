defmodule MrbeekenBackendWeb.UserController do
  use MrbeekenBackendWeb, :controller
  use JaResource
  plug JaResource
  alias MrbeekenBackendWeb.{UserView, User}
  alias MrbeekenBackend.Repo

  def me(conn, params) do
    current_user = conn.assigns.current_user
    conn
    |> put_status(200)
    |> render("show.json-api", data: current_user)
  end

  def unique(conn, params) do
    exists = (Repo.get_by(User, email: params["email"]) == nil)
    conn
    |> put_status(200)
    |> render("unique.json-api", %{unique: exists})
  end
end
