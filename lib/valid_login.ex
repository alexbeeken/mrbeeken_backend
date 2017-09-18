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
      Errors.render_error(conn, 422, Errors.missing_param)
    end
  end
end
