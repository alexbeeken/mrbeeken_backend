defmodule MrbeekenBackendWeb.UnitView do
  @moduledoc """
    Most of jsonapi is taken care of by ja serializer.
  """
  use JaSerializer.PhoenixView

  attributes [:title, :summary, :course_id]

end
