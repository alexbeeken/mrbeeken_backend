defmodule MrbeekenBackendWeb.AssessmentControllerTest do
  use MrbeekenBackendWeb.ConnCase

  alias MrbeekenBackendWeb.{Assessment}

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
    user = insert(:user, superuser: true)
    login(conn, user)
  end

  def assessment_attrs(unit) do
    %{
      title: "Test Assessment Title",
      order: "0",
      unit_id: unit.id
    }
  end

  def assessment_params(unit) do
    %{
      data: %{
        type: "Assessment",
        attributes: assessment_attrs(unit)
      }
    }
  end

  test "#get returns an assessment object", %{ conn: conn } do
    conn = login_user(conn)
    assessment = insert(:assessment)

    conn = get conn, assessment_path(
      conn,
      :show,
      assessment.id
    )

    response = json_response(conn, 200)
    assert response["data"]["type"] == "assessment"
    assert response["data"]["id"]
      == Integer.to_string(assessment.id)
    assert response["data"]["attributes"]["title"]
      == assessment.title
  end

  test "#index returns a list of assessment objects scoped to unit",
    %{
      conn: conn
    } do
    assessment = insert(:assessment)
    unit = assessment.unit
    assessment2 = insert(:assessment,
      unit: unit
    )
    insert(:assessment)

    conn = get conn, assessment_path(
      conn,
      :index,
      %{ filter: %{ unit_id: unit.id } }
    )

    response = json_response(conn, 200)
    first_object = Enum.at(response["data"], 0)
    second_object = Enum.at(response["data"], 1)
    last_object = Enum.at(response["data"], 2)
    assert first_object["type"] == "assessment"
    assert first_object["id"]
      == Integer.to_string(assessment.id)
    assert first_object["attributes"]["title"]
      == assessment.title
    assert second_object["type"] == "assessment"
    assert second_object["id"]
      == Integer.to_string(assessment2.id)
    assert second_object["attributes"]["title"]
      == assessment2.title
    assert last_object == nil
  end

  test "#index returns a list of assessment objects in order",
    %{
      conn: conn
    } do
    insert(:assessment, title: "first", order: 0)
    insert(:assessment, title: "second", order: 1)

    conn = get conn, assessment_path(
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
    conn = login_superuser(conn)
    unit = insert(:unit)
    conn = post conn, assessment_path(
      conn,
      :create,
      assessment_params(unit)
    )

    response = json_response(conn, 201)
    assert response["data"]["type"] == "assessment"
    assert response["data"]["attributes"]["title"]
      == assessment_attrs(unit).title
  end

  test "#update returns updates object",
    %{
      conn: conn
    } do
    unit = insert(:unit)
    assessment = insert(:assessment)
    conn = patch conn, assessment_path(
      conn,
      :update,
      assessment.id,
      assessment_params(unit)
    )

    response = json_response(conn, 200)
    assert response["data"]["type"] == "assessment"
    assert response["data"]["attributes"]["title"]
      == assessment_attrs(unit).title
  end

  test "#delete removes object", %{ conn: conn } do

    assessment = insert(:assessment)
    assert Repo.aggregate(Assessment, :count, :id) == 1
    conn = delete conn, assessment_path(
      conn,
      :delete,
      assessment.id
    )
    assert Repo.aggregate(Assessment, :count, :id) == 0
    assert conn.status == 204
  end
end
