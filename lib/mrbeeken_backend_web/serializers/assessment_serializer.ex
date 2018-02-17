defmodule MrbeekenBackendWeb.AssessmentSerializer do
  use JaSerializer

  location "/assessments/:id"
  attributes [:title, :order, :unit_id]
end
