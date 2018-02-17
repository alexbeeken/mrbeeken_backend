defmodule MrbeekenBackendWeb.LessonSerializer do
  use JaSerializer

  location "/lessons/:id"
  attributes [:title, :content, :order, :unit_id]
end
