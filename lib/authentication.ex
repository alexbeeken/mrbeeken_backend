defmodule MrbeekenBackendWeb.Authentication do
  import Plug.Conn
  import Phoenix.Controller

  alias MrbeekenBackend.{Repo}
  alias MrbeekenBackendWeb.{User, ErrorView, Errors}

  def init(opts) do
    opts
  end

  def call(conn, opts) do
    try do
      parsed_token = parse_token(conn)
      verify_token(conn, parsed_token)
    rescue
      e in RuntimeError -> e
      conn
      |> Errors.render_error(401, e.message)
      |> halt()
    end
  end

  def verify_token(conn, parsed_token) do
    case Guardian.decode_and_verify(parsed_token) do
      {:error, _claims} ->
        raise Errors.token_invalid
      {:ok, claims} ->
        "User:" <> user_id = claims["sub"]
        user = Repo.get(User, user_id)
        assign(conn, :current_user, user)
    end
  end

  def find_token([ h | t ] \\ [ nil | nil]) do
    case h do
      {"authorization", token} ->
        token
      {_, _} ->
        if Enum.empty?(t), do: raise Errors.token_missing
        find_token(t)
    end
  end

  def parse_token(conn) do
    "Bearer " <> raw_token = find_token(conn.req_headers)
    unless raw_token, do: raise Errors.token_format_bad
    raw_token
  end
end
