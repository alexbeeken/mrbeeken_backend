require IEx
defmodule MrbeekenBackendWeb.DummyControllerTest do
  use MrbeekenBackendWeb.ConnCase
  alias MrbeekenBackend.{Repo}
  alias MrbeekenBackendWeb.{DummyView, User, Errors}
  import MrbeekenBackendWeb.{JsonApi, LoginHelper, TestCreds, Factory}

  setup do
    user = insert(:user)
    conn = build_conn()
      |> json_api_headers
    {:ok, conn: conn, user: user}
  end

  def render_json(template) do
    DummyView.render(template, %{}) |> encode
  end

  test "#show returns ok for successful authentication", %{conn: conn, user: user} do
    {:ok, jwt, _} = Guardian.encode_and_sign(user)
    conn = conn
      |> put_req_header("authorization", "Bearer #{jwt}")
      |> get dummy_path(conn, :show)

    assert json_response(conn, 200) == render_json("show.json-api")
  end

  test "#show returns error with invalid token", %{conn: conn, user: user} do
    {:ok, jwt, _} = Guardian.encode_and_sign(user)
    conn = conn
      |> put_req_header("authorization", "Bearer #{jwt}MESSITUP")
      |> get dummy_path(conn, :show)

    assert json_response(conn, 400) == render_error("400.json-api", %{title: Errors.session_bad})
  end

  test "#show returns error with no token", %{conn: conn, user: user} do
    {:ok, jwt, _} = Guardian.encode_and_sign(user)
    conn = conn
      |> get dummy_path(conn, :show)

    assert json_response(conn, 400) == render_error("400.json-api", %{title: Errors.session_bad})
  end
end
