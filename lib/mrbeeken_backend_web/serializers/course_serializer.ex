defmodule MrbeekenBackendWeb.CourseSerializer do
  use JaSerializer

  location "/courses/:id"
  attributes [:title, :summary]
end
