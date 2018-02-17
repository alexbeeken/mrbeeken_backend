defmodule MrbeekenBackendWeb.LessonView do
  @moduledoc """
    Most of jsonapi is taken care of by ja serializer.
  """
  use JaSerializer.PhoenixView

  attributes [:title, :content, :order, :unit_id]
end
