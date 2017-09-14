defmodule MrbeekenBackendWeb.UsersControllerTest do
  use MrbeekenBackendWeb.ConnCase
  alias MrbeekenBackend.Repo
  alias MrbeekenBackendWeb.{User, UserView}
  import MrbeekenBackendWeb.{JsonApi, Factory, LoginHelper}

  setup do
    user = insert(:user)
    conn = build_conn()
      |> json_api_headers
      |> login(user)
    {:ok, conn: conn, user: user}
  end

  def render_json(template, assigns) do
    assigns = Map.new(assigns)

    UserView.render(template, assigns) |> encode
  end

  test "#show returns the current user object", %{conn: conn, user: user} do
    conn = get conn, user_path(conn, :show, user.id)

    assert json_response(conn, 200) == render_json("show.json-api", %{user: user})
  end

  test "#me returns the current user object from token", %{conn: conn, user: user} do
    conn = get conn, user_path(conn, :me)

    assert json_response(conn, 200) == render_json("show.json-api", %{user: user})
  end
end
