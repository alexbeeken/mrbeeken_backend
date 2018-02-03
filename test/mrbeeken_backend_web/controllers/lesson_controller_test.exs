defmodule MrbeekenBackendWeb.LessonControllerTest do
  use MrbeekenBackendWeb.ConnCase

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

  test "#get returns a lesson object",
    %{
      conn: conn,
      course: course
    } do
    lesson = insert(:lesson)

    conn = get conn, course_unit_lesson_path(
      conn,
      :show,
      lesson.unit.course.id,
      lesson.unit.id,
      lesson.id
    )

    response = json_response(conn, 200)
    assert response["data"]["type"] == "lesson"
    assert response["data"]["id"]
      == Integer.to_string(lesson.id)
    assert response["data"]["attributes"]["title"]
      == lesson.title
  end

  test "#index returns a list of lesson objects scoped to unit",
    %{
      conn: conn,
      course: course
    } do
    lesson = insert(:lesson)
    unit = lesson.unit
    lesson2 = insert(:lesson,
      unit: unit
    )
    lesson3 = insert(:lesson)

    conn = get conn, course_unit_lesson_path(
      conn,
      :index,
      course.id,
      unit.id
    )

    response = json_response(conn, 200)
    first_object = Enum.at(response["data"], 0)
    second_object = Enum.at(response["data"], 1)
    last_object = Enum.at(response["data"], 2)
    assert first_object["type"] == "lesson"
    assert first_object["id"]
      == Integer.to_string(lesson.id)
    assert first_object["attributes"]["title"]
      == lesson.title
    assert second_object["type"] == "lesson"
    assert second_object["id"]
      == Integer.to_string(lesson2.id)
    assert second_object["attributes"]["title"]
      == lesson2.title
    assert last_object == nil
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
    assert response["data"]["attributes"]["title"]
      == lesson_attrs.title
    assert response["data"]["attributes"]["content"]
      == lesson_attrs.content
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
    assert response["data"]["attributes"]["title"]
      == lesson_attrs.title
    assert response["data"]["attributes"]["content"]
      == lesson_attrs.content
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
