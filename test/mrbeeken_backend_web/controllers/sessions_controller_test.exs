require IEx
defmodule MrbeekenBackendWeb.SessionsControllerTest do
  use MrbeekenBackendWeb.ConnCase
  alias MrbeekenBackend.Repo
  alias MrbeekenBackendWeb.{User,Errors,SessionsView}
  import MrbeekenBackendWeb.{JsonApi, TestCreds, Factory}

  @valid_attrs %{username: "test@example.com", password: "123456abc"}
  @wrong_password %{username: "test@example.com", password: "133456abc"}
  @user_attrs %{email: "test@example.com", password: "123456abc", password_confirmation: "123456abc"}

  setup do
    user = insert(:user)
    conn = build_conn()
      |> json_api_headers
    {:ok, conn: conn, user: user}
  end

  def render_json(template, assigns) do
    assigns = Map.new(assigns)

    SessionsView.render(template, assigns) |> encode
  end

  test "#login successfully returns a token", %{conn: conn, user: user} do
    conn = post conn, sessions_path(conn, :login), valid_login_params(user)

    assert json_response(conn, 201)
  end

  test "#login gives correct error for bad password", %{conn: conn, user: user} do
    conn = post conn, sessions_path(conn, :login), bad_password_login_params(user)

    assert json_response(conn, 400) == render_error("400.json-api", %{title: Errors.password_bad})
  end

  test "#logout returns ok for good token", %{conn: conn, user: user} do
    {:ok, jwt, _} = Guardian.encode_and_sign(user)

    conn = conn |> put_req_header("authorization", "Bearer #{jwt}")
    conn = post conn, sessions_path(conn, :logout)

    assert json_response(conn, 200) == render_json("logout.json-api", %{})
  end

  test "#logout returns error for bad token", %{conn: conn, user: user} do
    {:ok, jwt, _} = Guardian.encode_and_sign(user)

    conn = conn |> put_req_header("authorization", "Bearer #{jwt}MESSITUP")
    conn = post conn, sessions_path(conn, :logout)

    assert json_response(conn, 200) == render_json("logout.json-api", %{})
  end
end
