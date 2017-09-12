defmodule MrbeekenBackendWeb.UsersControllerTest do
  use MrbeekenBackendWeb.ConnCase
  alias MrbeekenBackend.Repo
  alias MrbeekenBackendWeb.User
  alias MrbeekenBackendWeb.Session

  @request_attrs %{username: "test@example.com", password: "123456abc"}
  @user_attrs %{email: "test@example.com", password: "123456abc", password_confirmation: "123456abc"}

  test "#show returns a user object" do
    # user = %User{} |> User.changeset(@user_attrs) |> Repo.insert!
    # conn = post conn, sessions_path(conn, :create), @valid_attrs
    # session = Session |> Repo.get_by(user_id: user.id)
    #
    # assert json_response(conn, 201) == render_json("show.json-api", %{session: session})
  end
end
