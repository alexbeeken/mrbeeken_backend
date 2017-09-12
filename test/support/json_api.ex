defmodule JsonApi do
  alias MrbeekenBackendWeb.ErrorView
  import Plug.Conn

  def json_api_headers(conn) do
    conn
      |> put_req_header("accept", "application/vnd.api+json")
      |> put_req_header("content-type", "application/vnd.api+json")
  end

  def valid_token(conn) do
    conn
      |> put_req_header("bearer", "12345")
  end

  def invalid_token(conn) do
    conn
      |> put_req_header("bearer", "123456")
  end

  def render_error(template, assigns) do
    assigns = Map.new(assigns)

    ErrorView.render(template, assigns) |> encode
  end

  def encode(response) do
    response
    |> Poison.encode!
    |> Poison.decode!
  end
end
