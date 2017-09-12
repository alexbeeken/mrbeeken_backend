defmodule MrbeekenBackendWeb.UsersControllerTest do
  use MrbeekenBackendWeb.ConnCase
  alias MrbeekenBackend.Repo
  alias MrbeekenBackendWeb.{User, UserView}
  import JsonApi

  @request_attrs %{username: "test@example.com", password: "123456abc"}
  @user_attrs %{email: "test@example.com", password: "123456abc", password_confirmation: "123456abc"}

  setup do
    conn = build_conn()
      |> json_api_headers
    {:ok, conn: conn}
  end

  def render_json(template, assigns) do
    assigns = Map.new(assigns)

    UserView.render(template, assigns) |> encode
  end

  test "#show returns a user object", %{conn: conn} do
    # user = %User{} |> User.changeset(@user_attrs) |> Repo.insert!
    # conn = post conn, users_path(conn, :show), @valid_attrs
    #
    # assert json_response(conn, 201) == render_json("show.json-api", %{user: user})
  end
end
