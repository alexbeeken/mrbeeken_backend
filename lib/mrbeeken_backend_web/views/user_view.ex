defmodule MrbeekenBackendWeb.UserView do
  @moduledoc """
    Most of jsonapi is taken care of by ja serializer.
  """
  use JaSerializer.PhoenixView

  attributes [:email, :superuser]

  def render("unique.json-api", data) do
    %{
      meta: %{
        unique: data[:unique]
      }
    }
  end
end
