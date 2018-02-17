defmodule MrbeekenBackendWeb.UnitControllerTest do
  use MrbeekenBackendWeb.ConnCase

  alias MrbeekenBackendWeb.{Unit, Assessment}

  setup do
    course = insert(:course)
    conn =
      build_conn()
      |> json_api_headers
    {:ok, conn: login_superuser(conn), course: course}
  end

  def login_superuser(conn) do
    user = insert(:user, superuser: true)
    login(conn, user)
  end

  def login_user(conn) do
    user = insert(:user)
    login(conn, user)
  end

  def unit_attrs(course) do
    %{
      title: "Test Unit Title",
      summary: "Test Unit Summary",
      order: 0,
      course_id: course.id
    }
  end

  def unit_params(course) do
    %{
      data: %{
        type: "Unit",
        attributes: unit_attrs(course)
      }
    }
  end

  test "#get returns a unit object", %{ conn: conn } do
    conn = login_user(conn)
    unit = insert(:unit)

    conn = get conn, unit_path(conn, :show, unit.id)

    response = json_response(conn, 200)
    assert response["data"]["type"] == "unit"
    assert response["data"]["id"]
      == Integer.to_string(unit.id)
    assert response["data"]["attributes"]["title"]
      == unit.title
    assert response["data"]["attributes"]["summary"]
      == unit.summary
  end

  test "#get returns relationship data for assessment", %{ conn: conn } do
    conn = login_user(conn)
    unit = insert(:unit)
    assessment = insert(:assessment, unit: unit)

    conn = get conn, unit_path(
      conn,
      :show,
      unit.id
    )

    response = json_response(conn, 200)
    assessment_object =
      Enum.at(
        response["data"]["relationships"]["assessments"]["data"],
        0
      )
    assert response["data"]["type"] == "unit"
    assert response["data"]["id"]
      == Integer.to_string(unit.id)
    assert response["data"]["attributes"]["title"]
      == unit.title
    assert response["data"]["attributes"]["summary"]
      == unit.summary
    assert assessment_object["id"] == Integer.to_string(assessment.id)
  end

  test "#get returns relationship data for lesson", %{ conn: conn } do
    conn = login_user(conn)
    unit = insert(:unit)
    lesson = insert(:lesson, unit: unit)

    conn = get conn, unit_path(
      conn,
      :show,
      unit.id
    )

    response = json_response(conn, 200)
    lesson_object =
      Enum.at(
        response["data"]["relationships"]["lessons"]["data"],
        0
      )
    assert response["data"]["type"] == "unit"
    assert response["data"]["id"]
      == Integer.to_string(unit.id)
    assert response["data"]["attributes"]["title"]
      == unit.title
    assert response["data"]["attributes"]["summary"]
      == unit.summary
    assert lesson_object["id"] == Integer.to_string(lesson.id)
  end

  test "#index filter returns a list of unit objects scoped to course",
  %{
    conn: conn
  } do
    conn = login_user(conn)
    unit = insert(:unit)
    course = unit.course
    unit2 = insert(:unit,
      course: course
    )
    insert(:unit)

    conn = get conn, unit_path(
      conn,
      :index,
      filter: %{ course_id: course.id }
    )

    response = json_response(conn, 200)
    first_object = Enum.at(response["data"], 0)
    second_object = Enum.at(response["data"], 1)
    last_object = Enum.at(response["data"], 2)
    assert first_object["type"] == "unit"
    assert first_object["id"] == Integer.to_string(unit.id)
    assert first_object["attributes"]["title"]
      == unit.title
    assert first_object["attributes"]["summary"]
      == unit.summary
    assert second_object["type"] == "unit"
    assert second_object["id"] == Integer.to_string(unit2.id)
    assert second_object["attributes"]["title"]
      == unit2.title
    assert second_object["attributes"]["summary"]
      == unit2.summary
    assert last_object == nil
  end

  test "#index returns a list of unit objects in order",
    %{
      conn: conn
    } do
    insert(:unit, title: "first", order: 0)
    insert(:unit, title: "second", order: 1)

    conn = get conn, unit_path(
      conn,
      :index
    )

    response = json_response(conn, 200)
    first_object = Enum.at(response["data"], 0)
    second_object = Enum.at(response["data"], 1)
    assert first_object["attributes"]["title"] == "first"
    assert first_object["attributes"]["order"] == 0
    assert second_object["attributes"]["title"] == "second"
    assert second_object["attributes"]["order"] == 1
  end

  test "#create returns created object", %{ conn: conn } do
    course = insert(:course)
    conn = post conn, unit_path(
      conn,
      :create,
      unit_params(course)
    )

    response = json_response(conn, 201)
    assert response["data"]["type"] == "unit"
    assert response["data"]["attributes"]["title"]
      == unit_attrs(course).title
    assert response["data"]["attributes"]["summary"]
      == unit_attrs(course).summary
  end

  test "#update returns updated object", %{ conn: conn } do
    unit = insert(:unit)
    course = unit.course
    conn = patch conn, unit_path(
      conn,
      :update,
      unit.id,
      unit_params(course)
    )

    response = json_response(conn, 200)
    assert response["data"]["type"] == "unit"
    assert response["data"]["attributes"]["title"]
      == unit_attrs(course).title
    assert response["data"]["attributes"]["summary"]
      == unit_attrs(course).summary
  end

  test "#update order succeeds", %{ conn: conn } do
    unit = insert(:unit, order: 1123131)
    course = unit.course
    conn = patch conn, unit_path(
      conn,
      :update,
      unit.id,
      unit_params(course)
    )

    response = json_response(conn, 200)
    assert response["data"]["type"] == "unit"
    assert response["data"]["attributes"]["title"]
      == unit_attrs(course).title
    assert response["data"]["attributes"]["summary"]
      == unit_attrs(course).summary
    assert response["data"]["attributes"]["order"]
      == unit_attrs(course).order
  end

  test "#delete removes object", %{ conn: conn } do
    unit = insert(:unit)
    assert Repo.aggregate(Unit, :count, :id) == 1
    conn = delete conn, unit_path(
      conn,
      :delete,
      unit.id
    )

    assert Repo.aggregate(Unit, :count, :id) == 0
    assert conn.status == 204
  end

  test "#delete nilifies any child records", %{ conn: conn } do
    unit = insert(:unit)
    insert(:assessment, unit: unit)
    insert(:assessment, unit: nil)
    assert Repo.aggregate(Unit, :count, :id) == 1
    assert Repo.aggregate(Assessment, :count, :id) == 2
    conn = delete conn, unit_path(
      conn,
      :delete,
      unit.id
    )

    assert Repo.aggregate(Unit, :count, :id) == 0
    assert Repo.aggregate(Assessment, :count, :id) == 2
    assert conn.status == 204
  end
end
