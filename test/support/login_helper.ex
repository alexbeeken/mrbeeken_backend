defmodule MrbeekenBackendWeb.LoginHelper do
  @moduledoc """
    Simple way to login a user without having to stub anything
    from Guardian.
  """
  use Phoenix.ConnTest

  def login(conn, user) do
    {:ok, jwt, _} = Guardian.encode_and_sign(user)
    put_req_header(conn, "authorization", "Bearer #{jwt}")
  end
end
