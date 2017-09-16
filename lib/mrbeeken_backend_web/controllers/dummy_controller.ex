defmodule MrbeekenBackendWeb.DummyController do
  use MrbeekenBackendWeb, :controller

  alias MrbeekenBackendWeb.{ErrorView, Errors}

  def show(conn, _params) do
    if conn.assigns[:current_user] do
      conn
      |> put_status(200)
      |> render("success.json-api")
    else
      conn
      |> put_status(400)
      |> render(ErrorView, "400.json-api", %{title: Errors.session_bad})
    end
  end
end
