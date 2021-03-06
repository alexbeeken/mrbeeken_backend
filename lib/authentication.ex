defmodule MrbeekenBackendWeb.Authentication do
  @moduledoc """
    This plug is called every time a request needs to be
    authenticated.
    It looks for the token, parses it and then decodes it
    with Guardian.
  """

  import Plug.Conn

  alias MrbeekenBackend.{Repo}
  alias MrbeekenBackendWeb.{User, Errors}

  def init(opts) do
    opts
  end

  def call(conn, _opts) do
    try do
      parsed_token = parse_token(conn)
      verify_token(conn, parsed_token)
    rescue
      e in RuntimeError -> e
      Errors.render_error(conn, 401, e.message)
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
