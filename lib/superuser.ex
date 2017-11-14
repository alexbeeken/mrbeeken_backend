defmodule MrbeekenBackendWeb.Superuser do
  @moduledoc """
    Simple plug for checking that user is superuser.
  """
  import Plug.Conn
  import Phoenix.Controller

  alias MrbeekenBackendWeb.{ErrorView, Errors}

  def init(opts) do
    opts
  end

  def call(conn, opts) do
    if conn.assigns[:current_user].superuser do
      conn
    else
      Errors.render_error(conn, 403, Errors.not_allowed)
    end
  end
end
