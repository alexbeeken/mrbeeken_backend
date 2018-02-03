require IEx
defmodule MrbeekenBackendWeb.AssessmentController do
  use MrbeekenBackendWeb, :controller

  alias MrbeekenBackendWeb.{Assessment}
  alias MrbeekenBackend.Repo
  import Ecto.Query

  use JaResource

  plug JaResource

  def records(conn) do
    { unit_id, "" } = Integer.parse(conn.params["unit_id"])
    from a in Assessment, where: a.unit_id == ^unit_id
  end

  def handle_create(conn, params) do
    { unit_id, _ } = Integer.parse(conn.params["unit_id"])
    Repo.insert(%Assessment{
      title: params["title"],
      unit_id: unit_id
    })
  end
end
