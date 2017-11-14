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

  test "#create returns success when superuser", %{ conn: conn } do
    conn =
      conn
      |> login_superuser
      |> post post_path(conn, :create, post_params)

    response = json_response(conn, 201)
    assert response["data"]["type"] == "post"
    assert response["data"]["attributes"]["title"] == post_attrs.title
    assert response["data"]["attributes"]["summary"] == post_attrs.summary
    assert response["data"]["attributes"]["content"] == post_attrs.content
    assert response["data"]["attributes"]["thumbnail"] == post_attrs.thumbnail
    assert response["data"]["attributes"]["audio"] == post_attrs.audio
  end

  test "#show returns post object", %{ conn: conn } do
    post = insert(:post)
    conn = get conn, post_path(conn, :show, post)

    response = json_response(conn, 200)
    assert response["data"]["type"] == "post"
    assert response["data"]["attributes"]["title"] == post.title
    assert response["data"]["attributes"]["summary"] == post.summary
    assert response["data"]["attributes"]["content"] == post.content
    assert response["data"]["attributes"]["thumbnail"] == post.thumbnail
    assert response["data"]["attributes"]["audio"] == post.audio
  end

  test "#index returns post object", %{ conn: conn } do
    posts = insert_list(3, :post)
    conn = get conn, post_path(conn, :index)

    response = json_response(conn, 200)
    assert length(response["data"]) == 3
  end

  test "#delete removes post object if superuser", %{ conn: conn } do
    [ post1 | post2 ] = insert_list(2, :post)
    conn =
      conn
      |> login_superuser
      |> delete post_path(conn, :delete, post1)

    assert conn.status == 204
    assert length(Repo.all(Post)) == 1
  end

  test "#update changes post object if superuser", %{ conn: conn } do
    post = insert(:post)
    attrs = %{
      title: "UPDATED",
      summary: post.summary,
      content: post.content,
      thumbnail: post.thumbnail,
      audio: post.audio
    }

    conn =
      conn
      |> login_superuser
      |> put post_path(
        conn,
        :update,
        post.id,
        request_body(post.id, "post", attrs)
      )

    response = json_response(conn, 200)
    assert response["data"]["type"] == "post"
    assert response["data"]["attributes"]["title"] == "UPDATED"
    assert response["data"]["attributes"]["summary"] == post.summary
    assert response["data"]["attributes"]["content"] == post.content
    assert response["data"]["attributes"]["thumbnail"] == post.thumbnail
    assert response["data"]["attributes"]["audio"] == post.audio
  end
end
