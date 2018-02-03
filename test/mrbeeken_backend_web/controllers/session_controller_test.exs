defmodule MrbeekenBackendWeb.SessionControllerTest do
  use MrbeekenBackendWeb.ConnCase

  alias MrbeekenBackendWeb.{Errors, SessionView}

  setup do
    user = insert(:user)
    conn =
      build_conn()
      |> json_api_headers
    {:ok, conn: conn, user: user}
  end

  def render_json(template, assigns) do
    assigns = Map.new(assigns)

    encode(SessionView.render(template, assigns))
  end

  test "#login successfully returns a token", %{
    conn: conn,
    user: user
    } do
    conn = post(conn, session_path(conn, :login), valid_login_params(user))

    assert json_response(conn, 201)
  end

  test "#login gives correct error for bad password", %{
    conn: conn,
    user: user
    } do
    conn =
      post(conn, session_path(conn, :login), bad_password_login_params(user))

    assert json_response(conn, 404)
      == render_error("404.json-api", %{title: Errors.password_bad})
  end

  test "#logout returns ok for good token", %{
    conn: conn,
    user: user
    } do
    {:ok, jwt, _} = Guardian.encode_and_sign(user)

    conn =
      conn
      |> put_req_header("authorization", "Bearer #{jwt}")
      |> post(session_path(conn, :logout))

    assert json_response(conn, 200) == render_json("logout.json-api", %{})
  end

  test "#logout returns error for bad token", %{
    conn: conn,
    user: user
    } do
    {:ok, jwt, _} = Guardian.encode_and_sign(user)

    conn =
      conn
      |> put_req_header("authorization", "Bearer #{jwt}MESSITUP")
      |> post(session_path(conn, :logout))

    assert json_response(conn, 200) == render_json("logout.json-api", %{})
  end
end
