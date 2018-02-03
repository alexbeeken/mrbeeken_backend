defmodule MrbeekenBackendWeb.UnitController do
  use MrbeekenBackendWeb, :controller

  alias MrbeekenBackendWeb.Unit
  alias MrbeekenBackend.Repo
  import Ecto.Query

  use JaResource

  plug JaResource

  def records(conn) do
    { course_id, "" } = Integer.parse(conn.params["course_id"])
    from a in Unit, where: a.course_id == ^course_id
  end

  def handle_create(conn, params) do
    { course_id, _ } = Integer.parse(conn.params["course_id"])
    Repo.insert(%Unit{
      title: params["title"],
      summary: params["summary"],
      course_id: course_id
    })
  end
end
