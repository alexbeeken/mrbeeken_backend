defmodule MrbeekenBackendWeb.AssessmentSerializer do
  use JaSerializer

  location "/assessments/:id"
  attributes [:title, :unit_id]
end
