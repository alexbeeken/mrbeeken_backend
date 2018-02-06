defmodule MrbeekenBackendWeb.LessonController do
  use MrbeekenBackendWeb, :controller

  alias MrbeekenBackendWeb.Lesson
  alias MrbeekenBackend.Repo
  import Ecto.Query

  use JaResource

  plug JaResource

  def filter(_conn, query, "unit_id", unit_id) do
    where(query, unit_id: ^unit_id)
  end
end
