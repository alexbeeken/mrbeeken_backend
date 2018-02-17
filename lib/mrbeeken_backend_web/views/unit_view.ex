defmodule MrbeekenBackendWeb.UnitView do
  @moduledoc """
    Most of jsonapi is taken care of by ja serializer.
  """
  alias MrbeekenBackendWeb.{
    Assessment,
    AssessmentSerializer,
    Lesson,
    LessonSerializer
  }
  alias MrbeekenBackend.Repo
  use JaSerializer.PhoenixView
  import Ecto.Query

  attributes [:title, :summary, :order_num, :course_id]

  has_many :assessments,
    serializer: AssessmentSerializer,
    include: true

  def assessments(unit, _) do
    query = from a in Assessment, where: a.unit_id == ^unit.id
    Repo.all(query)
  end

  has_many :lessons,
    serializer: LessonSerializer,
    include: true

  def lessons(unit, _) do
    query = from a in Lesson, where: a.unit_id == ^unit.id
    Repo.all(query)
  end
end
