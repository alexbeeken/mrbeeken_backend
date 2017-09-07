defmodule MrbeekenBackendWeb.ErrorView do
  use JaSerializer.PhoenixView

  def render("404.json-api", data) do
    %{
      errors: [
        %{
          title: "route not found"
        }
      ]
    }
  end
end
