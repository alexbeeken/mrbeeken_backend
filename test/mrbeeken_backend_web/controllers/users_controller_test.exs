defmodule MrbeekenBackendWeb.UserControllerTest do
  use MrbeekenBackendWeb.ConnCase

  alias MrbeekenBackendWeb.{UserView}

  setup do
    user = insert(:user)
    conn =
      build_conn()
      |> json_api_headers
      |> login(user)
    {:ok, conn: conn, user: user}
  end

  def super_user_conn do
    user = insert(:user, superuser: true)
    conn =
      build_conn()
      |> json_api_headers
      |> login(user)
    {:ok, conn: conn, user: user}
  end

  def no_user_conn do
    conn = json_api_headers(build_conn())
  end

  def render_json(template, assigns) do
    assigns = Map.new(assigns)

    encode(UserView.render(template, assigns))
  end

  def create_params do
    %{
      data: %{
        type: "Post",
        attributes: valid_registration_params()
      }
    }
  end

  test "#create returns success when successful" do
    conn = no_user_conn
    conn = post conn, user_path(conn, :create, create_params)

    response = json_response(conn, 201)["data"]
    assert response["type"] == "user"
    assert response["attributes"]["email"] == create_params.data.attributes.email
  end

  test "#show returns user info if superuser" do
    {:ok, conn: conn, user: user} = super_user_conn
    conn = get conn, user_path(conn, :show, user.id)

    assert json_response(conn, 200)
      == render_json("show.json-api", %{user: user})
  end

  test "#me returns the current user object from token", %{
    conn: conn,
    user: user
    } do
    conn = get conn, user_path(conn, :me)

    response = json_response(conn, 200)
    assert response["data"]["type"] == "user"
    assert response["data"]["id"] == Integer.to_string(user.id)
    assert response["data"]["attributes"]["email"] == user.email
  end

  test "#unique returns true in meta if email available", %{
    conn: conn
    } do
    conn = get conn, user_path(conn, :unique, "buttermilk555@gmail.com")

    response = json_response(conn, 200)
    assert response["meta"]["unique"] == "1"
  end

  test "#unique returns false in meta if email unavailable", %{
    conn: conn,
    user: user
    } do
    conn = get conn, user_path(conn, :unique, user.email)

    response = json_response(conn, 200)
    assert response["meta"]["unique"] == "0"
  end
end
