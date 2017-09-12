defmodule MrbeekenBackendWeb.DummyControllerTest do
  use MrbeekenBackendWeb.ConnCase
  alias MrbeekenBackendWeb.{DummyView}
  import JsonApi

  setup do
    conn = build_conn()
      |> json_api_headers
    {:ok, conn: conn}
  end

  def render_json(template, assigns) do
    assigns = Map.new(assigns)

    DummyView.render(template, assigns) |> encode
  end

  test "#show returns ok with valid token", %{conn: conn} do
    conn = conn |> valid_token
    conn = get conn, dummy_path(conn, :show)

    assert json_response(conn, 201) == render_json("show.json-api", %{status: "ok"})
  end

  test "#show returns error with invalid token", %{conn: conn} do
    conn = conn |> invalid_token
    conn = get conn, dummy_path(conn, :show)

    assert json_response(conn, 400) == render_json("error.json-api", %{status: "error"})
  end
end
