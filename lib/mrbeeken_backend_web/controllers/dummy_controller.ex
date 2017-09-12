defmodule MrbeekenBackendWeb.DummyController do
  use MrbeekenBackendWeb, :controller

  def show(conn, _params) do
    token = conn.req_headers[:bearer]
    case Guardian.decode_and_verify(token) do
      {:ok, _claims} ->
        conn
        |> put_status(201)
        |> render("show.json-api", %{})
      {:error, _claims} ->
        conn
        |> put_status(400)
        |> render("error.json-api", %{})
    end
  end
end
