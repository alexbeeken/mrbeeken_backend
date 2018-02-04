defmodule MrbeekenBackendWeb.UnitControllerTest do
  use MrbeekenBackendWeb.ConnCase

  alias MrbeekenBackendWeb.{Unit, Assessment}
  import Ecto.Query

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

  def unit_attrs do
    %{
      title: "Test Unit Title",
      summary: "Test Unit Summary"
    }
  end

  def unit_params do
    %{
      data: %{
        type: "Unit",
        attributes: unit_attrs()
      }
    }
  end

  test "#get returns a unit object", %{ conn: conn } do
    unit = insert(:unit)

    conn = get conn, course_unit_path(
      conn,
      :show,
      unit.course.id,
      unit.id
    )

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
    unit = insert(:unit)
    assessment = insert(:assessment, unit: unit)

    conn = get conn, course_unit_path(
      conn,
      :show,
      unit.course.id,
      unit.id
    )

    response = json_response(conn, 200)
    assessment_object = Enum.at(response["data"]["relationships"]["assessments"]["data"], 0)
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
    unit = insert(:unit)
    lesson = insert(:lesson, unit: unit)

    conn = get conn, course_unit_path(
      conn,
      :show,
      unit.course.id,
      unit.id
    )

    response = json_response(conn, 200)
    lesson_object = Enum.at(response["data"]["relationships"]["lessons"]["data"], 0)
    assert response["data"]["type"] == "unit"
    assert response["data"]["id"]
      == Integer.to_string(unit.id)
    assert response["data"]["attributes"]["title"]
      == unit.title
    assert response["data"]["attributes"]["summary"]
      == unit.summary
    assert lesson_object["id"] == Integer.to_string(lesson.id)
  end

  test "#index returns a list of unit objects scoped to course",
    %{
      conn: conn
    } do
    unit = insert(:unit)
    course = unit.course
    unit2 = insert(:unit,
      course: course
    )
    insert(:unit)

    conn = get conn, course_unit_path(
      conn,
      :index,
      course.id
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


  test "#create returns created object",
    %{
      conn: conn,
      course: course
    } do

    conn = post conn, course_unit_path(
      conn,
      :create,
      course.id,
      unit_params()
    )

    response = json_response(conn, 201)
    assert response["data"]["type"] == "unit"
    assert response["data"]["attributes"]["title"] == unit_attrs().title
    assert response["data"]["attributes"]["summary"] == unit_attrs().summary
  end

  test "#update returns updates object", %{ conn: conn } do
    unit = insert(:unit)
    course = unit.course
    conn = patch conn, course_unit_path(
      conn,
      :update,
      course.id,
      unit.id,
      unit_params()
    )

    response = json_response(conn, 200)
    assert response["data"]["type"] == "unit"
    assert response["data"]["attributes"]["title"] == unit_attrs().title
    assert response["data"]["attributes"]["summary"] == unit_attrs().summary
  end

  test "#delete removes object", %{ conn: conn } do
    unit = insert(:unit)
    assert Repo.aggregate(Unit, :count, :id) == 1
    conn = delete conn, course_unit_path(
      conn,
      :delete,
      unit.course.id,
      unit.id
    )

    assert Repo.aggregate(Unit, :count, :id) == 0
    assert conn.status == 204
  end

  test "#delete nilifies any child records", %{ conn: conn } do
    unit = insert(:unit)
    insert(:assessment, unit: unit)
    insert(:assessment)
    assert Repo.aggregate(Unit, :count, :id) == 1
    assert Repo.aggregate(Assessment, :count, :id) == 2
    conn = delete conn, course_unit_path(
      conn,
      :delete,
      unit.course.id,
      unit.id
    )

    assert Repo.aggregate(Unit, :count, :id) == 0
    assert Repo.aggregate(Assessment, :count, :id) == 2
    assert conn.status == 204
  end
end
