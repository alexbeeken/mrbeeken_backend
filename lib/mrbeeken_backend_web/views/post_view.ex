defmodule MrbeekenBackendWeb.PostView do
  @moduledoc """
    Most of jsonapi is taken care of by ja serializer.
  """
  use JaSerializer.PhoenixView

  attributes [:title, :summary, :content, :thumbnail, :audio]

end
