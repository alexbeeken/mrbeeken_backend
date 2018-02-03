defmodule MrbeekenBackendWeb.LessonControllerTest do
  use MrbeekenBackendWeb.ConnCase

  import MrbeekenBackendWeb.{JsonApi, Factory, LoginHelper}

  alias MrbeekenBackend.Repo
  alias MrbeekenBackendWeb.{Lesson}

  setup do
    course = insert(:course)
    unit = insert(:unit)
    conn =
      build_conn()
      |> json_api_headers
    {:ok, conn: login_superuser(conn), course: course, unit: unit}
  end

  def login_superuser(conn) do
    user = insert(:user, superuser: true)
    login(conn, user)
  end

  def lesson_attrs do
    %{
      title: "Test Lesson Title",
      content: "Test Lesson Content"
    }
  end

  def lesson_params do
    %{
      data: %{
        type: "Lesson",
        attributes: lesson_attrs
      }
    }
  end

  test "#create returns created object",
    %{
      conn: conn,
      course: course,
      unit: unit
    } do

    conn = post conn, course_unit_lesson_path(
      conn,
      :create,
      course.id,
      unit.id,
      lesson_params
    )

    response = json_response(conn, 201)
    assert response["data"]["type"] == "lesson"
    assert response["data"]["attributes"]["title"] == lesson_attrs.title
    assert response["data"]["attributes"]["content"] == lesson_attrs.content
  end

  test "#update returns updates object",
    %{
      conn: conn,
      course: course,
      unit: unit
    } do

    lesson = insert(:lesson)
    conn = patch conn, course_unit_lesson_path(
      conn,
      :update,
      lesson.unit.course.id,
      lesson.unit.id,
      lesson.id,
      lesson_params
    )

    response = json_response(conn, 200)
    assert response["data"]["type"] == "lesson"
    assert response["data"]["attributes"]["title"] == lesson_attrs.title
    assert response["data"]["attributes"]["content"] == lesson_attrs.content
  end

  test "#delete removes object",
    %{
      conn: conn,
      course: course,
      unit: unit
    } do

    lesson = insert(:lesson)
    assert Repo.aggregate(Lesson, :count, :id) == 1
    conn = delete conn, course_unit_lesson_path(
      conn,
      :delete,
      lesson.unit.course.id,
      lesson.unit.id,
      lesson.id
    )
    assert Repo.aggregate(Lesson, :count, :id) == 0
    assert conn.status == 204
  end
end
