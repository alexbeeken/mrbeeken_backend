defmodule MrbeekenBackendWeb.Authentication do
  import Plug.Conn

  alias MrbeekenBackend.{Repo}
  alias MrbeekenBackendWeb.{User}

  def init(opts) do
    opts
  end

  def call(conn, opts) do
    token = find_token(conn.req_headers)
    "Bearer " <> token = token
    case Guardian.decode_and_verify(token) do
      {:ok, claims} ->
        "User:" <> user_id = claims["sub"]
        user = User |> Repo.get(user_id)
        conn
        |> assign(:current_user, user)
      {:error, _claims} ->
        conn
    end
  end

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
end
