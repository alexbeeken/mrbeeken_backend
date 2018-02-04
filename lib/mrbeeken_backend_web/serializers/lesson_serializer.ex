defmodule MrbeekenBackendWeb.LessonSerializer do
  use JaSerializer

  location "/lessons/:id"
  attributes [:title, :content, :unit_id]
end
