defmodule MrbeekenBackendWeb.JsonApi do
  alias MrbeekenBackendWeb.ErrorView
  import Plug.Conn
  import MrbeekenBackendWeb.TestCreds

  def json_api_headers(conn) do
    conn
    |> put_req_header("accept", "application/vnd.api+json")
    |> put_req_header("content-type", "application/vnd.api+json")
  end

  def valid_token(conn) do
    conn
    |> put_req_header("authorization", TestCreds.valid_token)
  end

  def invalid_token(conn) do
    conn
    |> put_req_header("authorization", TestCreds.invalid_token)
  end

  def render_error(template, assigns) do
    assigns = Map.new(assigns)

    encode(ErrorView.render(template, assigns))
  end

  def encode(response) do
    response
    |> Poison.encode!
    |> Poison.decode!
  end
end
