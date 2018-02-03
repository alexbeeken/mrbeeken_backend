defmodule MrbeekenBackendWeb.UnitControllerTest do
  use MrbeekenBackendWeb.ConnCase

  import MrbeekenBackendWeb.{JsonApi, Factory, LoginHelper, TestCreds}

  alias MrbeekenBackend.Repo
  alias MrbeekenBackendWeb.{Unit, UnitView}

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
        attributes: unit_attrs
      }
    }
  end

  test "#create returns created object",
    %{
      conn: conn,
      course: course
    } do

    conn = post conn, course_unit_path(conn, :create, course.id, unit_params)

    response = json_response(conn, 201)
    assert response["data"]["type"] == "unit"
    assert response["data"]["attributes"]["title"] == unit_attrs.title
    assert response["data"]["attributes"]["summary"] == unit_attrs.summary
  end

  test "#update returns updates object",
    %{
      conn: conn,
      course: course
    } do

    unit = insert(:unit)
    course = unit.course
    conn = patch conn, course_unit_path(conn, :update, course.id, unit.id, unit_params)

    response = json_response(conn, 200)
    assert response["data"]["type"] == "unit"
    assert response["data"]["attributes"]["title"] == unit_attrs.title
    assert response["data"]["attributes"]["summary"] == unit_attrs.summary
  end

  test "#delete removes object",
    %{
      conn: conn,
      course: course
    } do

    unit = insert(:unit)
    assert Repo.aggregate(Unit, :count, :id) == 1
    conn = delete conn, course_unit_path(conn, :delete, unit.course.id, unit.id)

    assert Repo.aggregate(Unit, :count, :id) == 0
    assert conn.status == 204
  end
end
