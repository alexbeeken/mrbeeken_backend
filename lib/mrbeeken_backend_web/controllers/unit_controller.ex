defmodule MrbeekenBackendWeb.UnitController do
  use MrbeekenBackendWeb, :controller

  alias MrbeekenBackendWeb.Unit
  alias MrbeekenBackend.Repo

  use JaResource

  plug JaResource

  def handle_create(conn, params) do
    { course_id, _ } = Integer.parse(conn.params["course_id"])
    unit =
      Repo.insert(%Unit{
        title: params["title"],
        summary: params["summary"],
        course_id: course_id
      })
  end
end
