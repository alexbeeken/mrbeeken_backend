defmodule MrbeekenBackendWeb.SessionsControllerTest do
  use MrbeekenBackendWeb.ConnCase
  alias MrbeekenBackend.Repo
  alias MrbeekenBackendWeb.{User,Errors,SessionsView}
  import JsonApi
  import TestCreds

  @valid_attrs %{username: "test@example.com", password: "123456abc"}
  @wrong_password %{username: "test@example.com", password: "133456abc"}
  @user_attrs %{email: "test@example.com", password: "123456abc", password_confirmation: "123456abc"}

  setup do
    conn = build_conn()
      |> json_api_headers
    {:ok, conn: conn}
  end

  def render_json(template, assigns) do
    assigns = Map.new(assigns)

    SessionsView.render(template, assigns) |> encode
  end

  test "#token successfully returns a token", %{conn: conn} do
    user = %User{} |> User.changeset(@user_attrs) |> Repo.insert!
    conn = post conn, sessions_path(conn, :token), @valid_attrs
    token = "Bearer 12345"

    assert json_response(conn, 201) == render_json("token.json-api", %{token: token})
  end

  test "#token gives correct error for bad password", %{conn: conn} do
    user = %User{} |> User.changeset(@user_attrs) |> Repo.insert!
    conn = post conn, sessions_path(conn, :token), @valid_attrs
    token = TestCreds.valid_token

    assert json_response(conn, 201) == render_json("token.json-api", %{token: token})
  end

  test "#delete returns ok for good token", %{conn: conn} do
    user = %User{} |> User.changeset(@user_attrs) |> Repo.insert!
    conn = post conn, sessions_path(conn, :delete), %{token: TestCreds.valid_token}

    assert json_response(conn, 200) == render_json("delete.json-api", %{})
  end

  test "#delete returns error for bad token", %{conn: conn} do
    user = %User{} |> User.changeset(@user_attrs) |> Repo.insert!
    conn = post conn, sessions_path(conn, :delete), %{token: TestCreds.invalid_token}

    assert json_response(conn, 400) == render_error("400.json-api", %{title: Errors.session_bad})
  end
end
