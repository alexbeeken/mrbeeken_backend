defmodule MrbeekenBackendWeb.ValidLogin do
  import Plug.Conn
  import Phoenix.Controller

  alias MrbeekenBackendWeb.{ErrorView, Errors}

  def init(opts) do
    opts
  end

  def call(conn, opts) do
    if conn.params["email"] && conn.params["password"] do
      conn
    else
      render_error(conn)
    end
  end

  def render_error(conn) do
    conn
    |> put_status(422)
    |> render(ErrorView, "422.json-api", %{title: Errors.missing_param})
    |> halt()
  end
end
