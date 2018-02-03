defmodule MrbeekenBackendWeb.AssessmentController do
  use MrbeekenBackendWeb, :controller

  alias MrbeekenBackendWeb.Assessment
  alias MrbeekenBackend.Repo

  use JaResource

  plug JaResource

  def handle_create(conn, params) do
    { unit_id, _ } = Integer.parse(conn.params["unit_id"])
    unit =
      Repo.insert(%Assessment{
        title: params["title"],
        unit_id: unit_id
      })
  end
end
