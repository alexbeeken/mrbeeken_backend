defmodule MrbeekenBackendWeb.LoginHelper do
  use Phoenix.ConnTest

  alias MrbeekenBackend.Repo
  alias MrbeekenBackendWeb.User

  def login(conn, user) do
    {:ok, jwt, _} = Guardian.encode_and_sign(user)
    put_req_header(conn, "authorization", "Bearer #{jwt}")
  end
end
