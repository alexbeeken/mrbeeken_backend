defmodule MrbeekenBackendWeb.DummyController do
  use MrbeekenBackendWeb, :controller

  alias MrbeekenBackendWeb.{Errors}

  def show(conn, _params) do
    if conn.assigns[:current_user] do
      conn
      |> put_status(200)
      |> render("success.json-api")
    else
      Errors.render_error(conn, 400, Errors.session_bad)
    end
  end
end
