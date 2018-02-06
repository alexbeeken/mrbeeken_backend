defmodule MrbeekenBackendWeb.AssessmentController do
  use JaResource
  use MrbeekenBackendWeb, :controller

  import Ecto.Query

  plug JaResource

  def filter(_conn, query, "unit_id", unit_id) do
    where(query, unit_id: ^unit_id)
  end
end
