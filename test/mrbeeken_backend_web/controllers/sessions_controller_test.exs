defmodule MrbeekenBackendWeb.SessionsControllerTest do
  use MrbeekenBackendWeb.ConnCase
  alias MrbeekenBackend.Repo
  alias MrbeekenBackendWeb.{User,Session,Errors,SessionsView}
  import JsonApi

  @valid_attrs %{username: "test@example.com", password: "123456abc"}
  @invalid_attrs %{username: "test@example.com", password: "133456abc"}
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

  test "#create successfully returns a session object", %{conn: conn} do
    user = %User{} |> User.changeset(@user_attrs) |> Repo.insert!
    conn = post conn, sessions_path(conn, :create), @valid_attrs
    session = Session |> Repo.get_by(user_id: user.id)

    assert json_response(conn, 201) == render_json("show.json-api", %{session: session})
  end

  test "#create returns error for bad password", %{conn: conn} do
    user = %User{} |> User.changeset(@user_attrs) |> Repo.insert!
    conn = post conn, sessions_path(conn, :create), @invalid_attrs
    session = Session |> Repo.get_by(user_id: user.id)

    assert json_response(conn, 400) == render_error("400.json-api", %{title: Errors.password_bad})
  end
end
