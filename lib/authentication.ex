defmodule MrbeekenBackendWeb.Authentication do
  import Plug.Conn
  import Phoenix.Controller

  alias MrbeekenBackend.{Repo}
  alias MrbeekenBackendWeb.{User, ErrorView, Errors}

  def init(opts) do
    opts
  end

  def call(conn, opts) do
    conn.req_headers
    |> find_token()
    |> parse_token()
    |> verify_token()
  end
  
  def verify_token(parsed_token)
    case Guardian.decode_and_verify(parsed_token) do
      {:error, _claims} ->
        render_error(conn)
      {:ok, claims} ->
        "User:" <> user_id = claims["sub"]
        user = Repo.get(User, user_id)
        assign(conn, :current_user, user)
    end
  end

  def find_token([ h | t ] \\ [ nil | nil]) do
    case h do
      {"authorization", token} ->
        {:ok, token}
      {_, _} ->
        if Enum.empty?(t) do
          render_error(conn)
          {:error, nil}
        else
          find_token(t)
        end
    end
  end
  
  def parse_token(raw_token) do
    case raw_token do
      {:ok, raw_token} ->
        "Bearer " <> raw_token = raw_token
        raw_token
      {:error, _} ->
        {:error, nil}
      end
  end

  def render_error(conn) do
    conn
    |> put_status(400)
    |> render(ErrorView, "400.json-api", %{title: Errors.session_bad})
    |> halt()
  end
end
