defmodule MrbeekenBackendWeb.UserController do
  use MrbeekenBackendWeb, :controller
  use JaResource

  alias MrbeekenBackendWeb.User
  alias MrbeekenBackend.Repo

  plug JaResource

  def me(conn, params) do
    conn
    |> put_status(200)
    |> render("show.json-api", data: conn.assigns.current_user)
  end

  def unique(conn, params) do
    exists = if Repo.get_by(User, email: params["email"]), do: "0", else: "1"
    conn
    |> put_status(200)
    |> render("unique.json-api", %{unique: exists})
  end
end
