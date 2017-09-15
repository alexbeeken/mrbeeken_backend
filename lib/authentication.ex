defmodule MrbeekenBackendWeb.Authentication do
  import Plug.Conn
  import Phoenix.Controller

  alias MrbeekenBackend.{Repo}
  alias MrbeekenBackendWeb.{User, ErrorView, Errors}

  def init(opts) do
    opts
  end

  def call(conn, opts) do
    token = find_token(conn.req_headers)
    unless token do
      render_error(conn)
    else
      "Bearer " <> token = token
      case Guardian.decode_and_verify(token) do
        {:error, _claims} ->
          render_error(conn)
        {:ok, claims} ->
          "User:" <> user_id = claims["sub"]
          user = User |> Repo.get(user_id)
          conn
          |> assign(:current_user, user)
      end
    end
  end

  def find_token([ h | t ] \\ [ nil | nil]) do
    case h do
      {"authorization", x} ->
        x
      {_, _} ->
        if t == [] do
          nil
        else
          find_token(t)
        end
      _ ->
        nil
    end
  end

  def render_error(conn) do
    conn
    |> put_status(400)
    |> render(ErrorView, "400.json-api", %{title: Errors.session_bad})
    |> halt()
  end
end