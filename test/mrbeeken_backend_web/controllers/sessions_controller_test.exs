defmodule MrbeekenBackendWeb.SessionsControllerTest do
  use MrbeekenBackendWeb.ConnCase
  alias MrbeekenBackend.Repo
  alias MrbeekenBackendWeb.User

  @model_attrs %{email: "test@example.com", password: "123456"}
  @valid_attrs %{data: %{attributes: @model_attrs}}

  test "#create successfully returns a session object" do
    conn = build_conn()
    user = %User{} |> Map.merge(@model_attrs) |> Repo.insert!

    conn = post conn, sessions_path(conn, :create), @valid_attrs

    assert json_response(conn, 200) == %{
      data: %{
        type: "sessions",
        id: user.id,
        attributes: %{
            token: Guardian.encode_and_sign(user)
        }
      }
    }
  end
end
