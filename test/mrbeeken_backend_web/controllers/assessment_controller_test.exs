defmodule MrbeekenBackendWeb.AssessmentControllerTest do
  use MrbeekenBackendWeb.ConnCase

  alias MrbeekenBackendWeb.{Assessment}

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

  def assessment_attrs do
    %{
      title: "Test Assessment Title"
    }
  end

  def assessment_params do
    %{
      data: %{
        type: "Assessment",
        attributes: assessment_attrs
      }
    }
  end

  test "#create returns created object",
    %{
      conn: conn,
      course: course,
      unit: unit
    } do

    conn = post conn, course_unit_assessment_path(
      conn,
      :create,
      course.id,
      unit.id,
      assessment_params
    )

    response = json_response(conn, 201)
    assert response["data"]["type"] == "assessment"
    assert response["data"]["attributes"]["title"]
      == assessment_attrs.title
  end

  test "#update returns updates object",
    %{
      conn: conn,
      course: course,
      unit: unit
    } do

    assessment = insert(:assessment)
    conn = patch conn, course_unit_assessment_path(
      conn,
      :update,
      assessment.unit.course.id,
      assessment.unit.id,
      assessment.id,
      assessment_params
    )

    response = json_response(conn, 200)
    assert response["data"]["type"] == "assessment"
    assert response["data"]["attributes"]["title"]
      == assessment_attrs.title
  end

  test "#delete removes object",
    %{
      conn: conn,
      course: course,
      unit: unit
    } do

    assessment = insert(:assessment)
    assert Repo.aggregate(Assessment, :count, :id) == 1
    conn = delete conn, course_unit_assessment_path(
      conn,
      :delete,
      assessment.unit.course.id,
      assessment.unit.id,
      assessment.id
    )
    assert Repo.aggregate(Assessment, :count, :id) == 0
    assert conn.status == 204
  end
end
