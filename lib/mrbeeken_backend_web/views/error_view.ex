defmodule MrbeekenBackendWeb.ErrorView do
  use JaSerializer.PhoenixView

  def render("500.json-api", data) do
    JaSerializer.ErrorSerializer.format(data)
  end
end
