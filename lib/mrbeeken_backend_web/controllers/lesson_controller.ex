defmodule MrbeekenBackendWeb.LessonController do
  use JaResource
  use MrbeekenBackendWeb, :controller

  import Ecto.Query

  plug JaResource

  def filter(_conn, query, "unit_id", unit_id) do
    where(query, unit_id: ^unit_id)
  end

  def sort(_conn, query, _, _) do
    order_by(query, [{^"asc", :order}])
  end
end
