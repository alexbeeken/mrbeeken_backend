defmodule MrbeekenBackendWeb.UnitSerializer do
  use JaSerializer

  location "/units/:id"
  attributes [:title, :summary, :course_id]
end
