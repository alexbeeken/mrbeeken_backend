defmodule MrbeekenBackendWeb.ValidLogin do
  @moduledoc """
    Simple plug for checking that login params are present.
  """

  alias MrbeekenBackendWeb.Errors

  def init(opts) do
    opts
  end

  def call(conn, _opts) do
    if conn.params["email"] && conn.params["password"] do
      conn
    else
      Errors.render_error(conn, 422, Errors.missing_param)
    end
  end
end
