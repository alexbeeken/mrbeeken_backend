defmodule MrbeekenBackendWeb.UsersControllerTest do
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

  defp render_json(template, assigns) do
    assigns = Map.new(assigns)

    MrbeekenBackendWeb.SessionsView.render(template, assigns)
    |> Poison.encode!
    |> Poison.decode!
  end

  test "#show requires login", %{conn: conn} do
    
  end
end
