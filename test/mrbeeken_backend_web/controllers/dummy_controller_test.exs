defmodule MrbeekenBackendWeb.DummyControllerTest do
  use MrbeekenBackendWeb.ConnCase

  alias MrbeekenBackendWeb.{DummyView, User, Errors}

  setup do
    user = insert(:user)
    conn = build_conn()
      |> json_api_headers
    {:ok, conn: conn, user: user}
  end

  def render_json(template) do
    encode(DummyView.render(template, %{}))
  end

  test "#show returns ok for successful authentication", %{
    conn: conn,
    user: user
  } do
    {:ok, jwt, _} = Guardian.encode_and_sign(user)
    conn =
      conn
      |> put_req_header("authorization", "Bearer #{jwt}")
      |> get dummy_path(conn, :show)

    assert json_response(conn, 200) == render_json("success.json-api")
  end

  test "#show returns error with invalid token", %{
    conn: conn,
    user: user
  } do
    {:ok, jwt, _} = Guardian.encode_and_sign(user)
    conn =
      conn
      |> put_req_header("authorization", "Bearer #{jwt}MESSITUP")
      |> get dummy_path(conn, :show)

    assert json_response(conn, 401)
      == render_error("401.json-api", %{title: Errors.token_invalid})
  end

  test "#show returns error with no token", %{
    conn: conn,
    user: user
  } do

    {:ok, jwt, _} = Guardian.encode_and_sign(user)
    conn = get conn, dummy_path(conn, :show)

    assert json_response(conn, 401)
      == render_error("401.json-api", %{title: Errors.token_missing})
  end

  test "error hitting /superuser #show route if not superuser", %{
    conn: conn,
    user: user
  } do

    {:ok, jwt, _} = Guardian.encode_and_sign(user)
    conn =
      conn
      |> put_req_header("authorization", "Bearer #{jwt}")
      |> get superuser_test_path(conn, :show)

    assert json_response(conn, 403)
      == render_error("403.json-api", %{title: Errors.not_allowed})
  end

  test "superuser can hit /superuser #show route", %{
    conn: conn
  } do
    user = insert(:user, superuser: true)
    {:ok, jwt, _} = Guardian.encode_and_sign(user)

    conn =
      conn
      |> put_req_header("authorization", "Bearer #{jwt}")
      |> get superuser_test_path(conn, :show)

    assert json_response(conn, 200) == render_json("success.json-api")
  end
end
