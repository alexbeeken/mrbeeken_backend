defmodule MrbeekenBackendWeb.SessionsControllerTest do
  use MrbeekenBackendWeb.ConnCase
  alias MrbeekenBackend.Repo
  alias MrbeekenBackendWeb.User
  alias MrbeekenBackendWeb.Session

  @request_attrs %{username: "test@example.com", password: "123456abc"}
  @user_attrs %{email: "test@example.com", password: "123456abc", password_confirmation: "123456abc"}

  setup do
    conn = build_conn()
      |> put_req_header("accept", "application/vnd.api+json")
      |> put_req_header("content-type", "application/vnd.api+json")
    {:ok, conn: conn}
  end

  test "#create successfully returns a session object", %{conn: conn} do
    user = %User{}
            |> User.changeset(@user_attrs)
            |> Repo.insert!

    conn = post conn, sessions_path(conn, :create), @request_attrs
    session = Session |> Repo.get_by(user_id: user.id)

    assert json_response(conn, 201) == %{
      "data" => %{
        "attributes" => %{
          "token" => "12345"
        },
        "id" => "#{session.id}",
        "type" => "sessions"
      },
      "jsonapi" => %{
        "version" => "1.0"
      }
    }
  end
end
