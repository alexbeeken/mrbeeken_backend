defmodule MrbeekenBackendWeb.Superuser do
  @moduledoc """
    Simple plug for checking that user is superuser.
  """

  alias MrbeekenBackendWeb.Errors

  def init(opts) do
    opts
  end

  def call(conn, _opts) do
    if conn.assigns[:current_user].superuser do
      conn
    else
      Errors.render_error(conn, 403, Errors.not_allowed)
    end
  end
end
