defmodule MrbeekenBackendWeb.LessonControllerTest do
  use MrbeekenBackendWeb.ConnCase

  alias MrbeekenBackendWeb.{Lesson}

  setup do
    conn =
      build_conn()
      |> json_api_headers
    { :ok, conn: login_superuser(conn) }
  end

  def login_superuser(conn) do
    user = insert(:user, superuser: true)
    login(conn, user)
  end

  def login_user(conn) do
    user = insert(:user)
    login(conn, user)
  end


  def lesson_attrs(unit) do
    %{
      title: "Test Lesson Title",
      content: "Test Lesson Content",
      unit_id: unit.id
    }
  end

  def lesson_params(unit) do
    %{
      data: %{
        type: "Lesson",
        attributes: lesson_attrs(unit)
      }
    }
  end

  test "#get returns a lesson object", %{ conn: conn } do
    lesson = insert(:lesson)

    conn = get conn, lesson_path(
      conn,
      :show,
      lesson.id
    )

    response = json_response(conn, 200)
    assert response["data"]["type"] == "lesson"
    assert response["data"]["id"]
      == Integer.to_string(lesson.id)
    assert response["data"]["attributes"]["title"]
      == lesson.title
  end

  test "#index returns a list of lesson objects and filters to unit",
    %{
      conn: conn
    } do
    lesson = insert(:lesson)
    unit = lesson.unit
    lesson2 = insert(:lesson,
      unit: unit
    )
    insert(:lesson)

    conn = get conn, lesson_path(
      conn,
      :index,
      %{ filter: %{ unit_id: unit.id } }
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
      conn: conn
    } do
    unit = insert(:unit)
    conn = post conn, lesson_path(
      conn,
      :create,
      lesson_params(unit)
    )

    response = json_response(conn, 201)
    assert response["data"]["type"] == "lesson"
    assert response["data"]["attributes"]["title"]
      == lesson_attrs(unit).title
    assert response["data"]["attributes"]["content"]
      == lesson_attrs(unit).content
  end

  test "#update returns updates object", %{ conn: conn } do
    unit = insert(:unit)
    lesson = insert(:lesson)
    conn = patch conn, lesson_path(
      conn,
      :update,
      lesson.id,
      lesson_params(unit)
    )

    response = json_response(conn, 200)
    assert response["data"]["type"] == "lesson"
    assert response["data"]["attributes"]["title"]
      == lesson_attrs(unit).title
    assert response["data"]["attributes"]["content"]
      == lesson_attrs(unit).content
  end

  test "#delete removes object", %{ conn: conn } do
    lesson = insert(:lesson)
    assert Repo.aggregate(Lesson, :count, :id) == 1
    conn = delete conn, lesson_path(
      conn,
      :delete,
      lesson.id
    )
    assert Repo.aggregate(Lesson, :count, :id) == 0
    assert conn.status == 204
  end
end
