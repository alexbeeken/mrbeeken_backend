defmodule MrbeekenBackendWeb.CourseControllerTest do
  use MrbeekenBackendWeb.ConnCase

  alias MrbeekenBackendWeb.{Course, Unit}

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

  def course_params do
    %{
      data: %{
        type: "Course",
        attributes: course_attrs()
      }
    }
  end

  def course_attrs do
    %{
      title: "Test Title",
      summary: "Test Summary"
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
      |> post(course_path(conn, :create, course_params()))

    response = json_response(conn, 201)
    assert response["data"]["type"] == "course"
    assert response["data"]["attributes"]["title"] == course_attrs().title
    assert response["data"]["attributes"]["summary"] == course_attrs().summary
  end

  test "#show returns course object", %{ conn: conn } do
    course = insert(:course)
    conn = get conn, course_path(conn, :show, course)

    response = json_response(conn, 200)
    assert response["data"]["type"] == "course"
    assert response["data"]["attributes"]["title"] == course.title
    assert response["data"]["attributes"]["summary"] == course.summary
  end

  test "#show returns course object with relationships", %{ conn: conn } do
    course = insert(:course)
    unit = insert(:unit, course: course)
    conn = get conn, course_path(conn, :show, course)

    response = json_response(conn, 200)
    unit_object = Enum.at(response["data"]["relationships"]["units"]["data"], 0)
    assert response["data"]["type"] == "course"
    assert response["data"]["attributes"]["title"] == course.title
    assert response["data"]["attributes"]["summary"] == course.summary
    assert unit_object["id"] == Integer.to_string(unit.id)
  end

  test "#index returns course objects", %{ conn: conn } do
    insert_list(3, :course)
    conn = get conn, course_path(conn, :index)

    response = json_response(conn, 200)
    assert length(response["data"]) == 3
  end

  test "#delete removes course object if superuser", %{ conn: conn } do
    [ course1 | _ ] = insert_list(2, :course)
    conn =
      conn
      |> login_superuser
      |> delete(course_path(conn, :delete, course1))

    assert conn.status == 204
    assert length(Repo.all(Course)) == 1
  end

  test "#update changes post object if superuser", %{ conn: conn } do
    course = insert(:course)
    attrs = %{
      title: "UPDATED",
      summary: course.summary
    }

    conn =
      conn
      |> login_superuser
      |> put(course_path(
        conn,
        :update,
        course.id,
        request_body(course.id, "course", attrs)
      ))

    response = json_response(conn, 200)
    assert response["data"]["type"] == "course"
    assert response["data"]["attributes"]["title"] == "UPDATED"
    assert response["data"]["attributes"]["summary"] == course.summary
  end
end
