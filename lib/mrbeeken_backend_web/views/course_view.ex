defmodule MrbeekenBackendWeb.CourseView do
  @moduledoc """
    Most of jsonapi is taken care of by ja serializer.
  """
  use JaSerializer.PhoenixView

  alias MrbeekenBackendWeb.{Unit, UnitSerializer}
  alias MrbeekenBackend.{Repo}
  import Ecto.Query

  attributes [:title, :summary]

  has_many :units,
    serializer: UnitSerializer,
    include: true

  def units(course, _) do
    query = from a in Unit, where: a.course_id == ^course.id
    Repo.all(query)
  end
end
