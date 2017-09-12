defmodule MrbeekenBackendWeb.DummyController do
  use MrbeekenBackendWeb, :controller

  def find_token([ h | t ]) do
    case h do
      {"authorization", x} ->
        x
      {_, _} ->
        find_token(t)
      _ ->
        nil
    end
  end

  def show(conn, _params) do
    token = find_token(conn.req_headers)
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
