defmodule MrbeekenBackendWeb.LessonController do
  use MrbeekenBackendWeb, :controller

  alias MrbeekenBackendWeb.Lesson
  alias MrbeekenBackend.Repo

  use JaResource

  plug JaResource

  def handle_create(conn, params) do
    { unit_id, _ } = Integer.parse(conn.params["unit_id"])
    unit =
      Repo.insert(%Lesson{
        title: params["title"],
        content: params["content"],
        unit_id: unit_id
      })
  end
end
