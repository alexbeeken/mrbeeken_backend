defmodule MrbeekenBackendWeb.ErrorView do
  use MrbeekenBackendWeb, :view
  def render("404.json-api", data) do
    %{
      errors: [
        %{
          title: "route not found"
        }
      ]
    }
  end

  def render("400.json-api", data) do
    %{
      errors: [
        %{
          title: data[:title]
        }
      ]
    }
  end

  def render("500.json-api", data) do
    %{
      errors: [
        %{
          title: "Something has gone wrong"
        }
      ]
    }
  end
end
