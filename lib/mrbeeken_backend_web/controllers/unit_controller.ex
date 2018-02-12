require IEx
defmodule MrbeekenBackendWeb.UnitController do
  use JaResource
  use MrbeekenBackendWeb, :controller

  import Ecto.Query

  plug JaResource

  def filter(_conn, query, "course_id", course_id) do
    where(query, course_id: ^course_id)
  end
end
