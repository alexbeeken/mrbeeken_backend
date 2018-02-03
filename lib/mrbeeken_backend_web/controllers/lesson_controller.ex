defmodule MrbeekenBackendWeb.LessonController do
  use MrbeekenBackendWeb, :controller

  alias MrbeekenBackendWeb.Lesson
  alias MrbeekenBackend.Repo
  import Ecto.Query

  use JaResource

  plug JaResource

  def records(conn) do
    { unit_id, "" } = Integer.parse(conn.params["unit_id"])
    from a in Lesson, where: a.unit_id == ^unit_id
  end

  def handle_create(conn, params) do
    { unit_id, _ } = Integer.parse(conn.params["unit_id"])
    Repo.insert(%Lesson{
      title: params["title"],
      content: params["content"],
      unit_id: unit_id
    })
  end
end
