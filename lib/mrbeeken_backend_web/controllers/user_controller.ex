defmodule MrbeekenBackendWeb.UserController do
  use MrbeekenBackendWeb, :controller
  use JaResource
  plug JaResource

  def handle_show(conn, params) do
    token = find_token(conn.req_headers)
    case Guardian.decode_and_verify(token) do
      {:ok, _claims} ->
        user = Repo
      {:error, _claims} ->
        conn
        |> put_status(400)
        |> render("error.json-api", %{})
    end
  end
end
