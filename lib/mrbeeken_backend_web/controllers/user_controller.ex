defmodule MrbeekenBackendWeb.UserController do
  use MrbeekenBackendWeb, :controller
  use JaResource
  plug JaResource
  alias MrbeekenBackendWeb.UserView

  def me(conn, params) do
    current_user = conn.assigns.current_user
    conn
    |> put_status(200)
    |> render("show.json-api", data: current_user)
  end
end
