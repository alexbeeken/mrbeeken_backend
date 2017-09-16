defmodule MrbeekenBackendWeb.UserView do
  use JaSerializer.PhoenixView
  
  attributes [:email]

  def render("unique.json-api", data) do
    %{
      meta: %{
        unique: data[:unique]
      }
    }
  end
end
