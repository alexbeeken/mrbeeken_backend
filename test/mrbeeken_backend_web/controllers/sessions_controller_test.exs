defmodule MrbeekenBackendWeb.SessionsControllerTest do
  use MrbeekenBackendWeb.ConnCase
  alias MrbeekenBackend.Repo
  alias MrbeekenBackendWeb.User
  alias MrbeekenBackendWeb.Session

  @valid_attrs %{username: "test@example.com", password: "123456abc"}
  @invalid_attrs %{username: "test@example.com", password: "133456abc"}
  @user_attrs %{email: "test@example.com", password: "123456abc", password_confirmation: "123456abc"}

  setup do
    conn = build_conn()
      |> put_req_header("accept", "application/vnd.api+json")
      |> put_req_header("content-type", "application/vnd.api+json")
    {:ok, conn: conn}
  end

  defp render_json(template, assigns) do
    assigns = Map.new(assigns)

    MrbeekenBackendWeb.SessionsView.render(template, assigns)
    |> Poison.encode!
    |> Poison.decode!
  end

  defp render_error(template, assigns) do
    assigns = Map.new(assigns)

    MrbeekenBackendWeb.ErrorView.render(template, assigns)
    |> Poison.encode!
    |> Poison.decode!
  end

  test "#create successfully returns a session object", %{conn: conn} do
    user = %User{} |> User.changeset(@user_attrs) |> Repo.insert!
    conn = post conn, sessions_path(conn, :create), @valid_attrs
    session = Session |> Repo.get_by(user_id: user.id)

    assert json_response(conn, 201) == render_json("show.json-api", session: session)
  end

  test "#create returns error for bad password", %{conn: conn} do
    user = %User{} |> User.changeset(@user_attrs) |> Repo.insert!
    conn = post conn, sessions_path(conn, :create), @invalid_attrs
    session = Session |> Repo.get_by(user_id: user.id)

    assert json_response(conn, 400) == render_error("400.json-api", title: "bad password")
  end
end
