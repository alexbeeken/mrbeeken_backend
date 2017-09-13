require IEx
defmodule MrbeekenBackendWeb.LoginHelper do
  use Phoenix.ConnTest
  alias MrbeekenBackend.Repo
  alias MrbeekenBackendWeb.User
  alias MrbeekenBackendWeb.Router.Helpers
  import MrbeekenBackendWeb.TestCreds

  def login(conn, user) do
    conn
      |> login(user)
    user = %User{} |> User.changeset(user_attrs) |> Repo.insert!
    conn = post conn, Helpers.sessions_path(conn, :token), valid_login_params

    IEx.pry
    json_response(conn, 201)
  end
end
