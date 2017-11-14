defmodule MrbeekenBackendWeb.PostControllerTest do
  use MrbeekenBackendWeb.ConnCase

  import MrbeekenBackendWeb.{JsonApi, Factory, LoginHelper, TestCreds}

  alias MrbeekenBackend.Repo
  alias MrbeekenBackendWeb.{PostView, Post}

  setup do
    conn =
      build_conn()
      |> json_api_headers
    {:ok, conn: conn}
  end

  def login_superuser(conn) do
    user = insert(:user, superuser: true)
    login(conn, user)
  end

  def post_params do
    %{
      data: %{
        type: "Post",
        attributes: post_attrs
      }
    }
  end

  def post_attrs do
    %{
      title: "Test Title",
      summary: "Test Summary",
      content: "Test Content",
      thumbnail: "Test Thumbnail",
      audio: "Test Audio"
    }
  end

  def render_json(template, assigns) do
    assigns = Map.new(assigns)

    encode(PostView.render(template, assigns))
  end

  test "#create returns success when successful", %{ conn: conn } do
    conn =
      conn
      |> login_superuser
      |> post post_path(conn, :create, post_params)

    assert json_response(conn, 201)
      == render_json("show.json-api", %{post: post_attrs})
  end
end
