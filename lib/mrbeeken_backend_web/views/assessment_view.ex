defmodule MrbeekenBackendWeb.AssessmentView do
  @moduledoc """
    Most of jsonapi is taken care of by ja serializer.
  """
  use JaSerializer.PhoenixView

  attributes [:title, :order, :unit_id]
end
