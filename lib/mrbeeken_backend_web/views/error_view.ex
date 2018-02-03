defmodule MrbeekenBackendWeb.ErrorView do
  use MrbeekenBackendWeb, :view

  alias MrbeekenBackendWeb.Errors

  def render("400.json-api", data) do
    %{
      errors: [
        %{
          title: data[:title]
        }
      ]
    }
  end

  def render("500.json-api", _) do
    %{
      errors: [
        %{
          title: "Something has gone wrong"
        }
      ]
    }
  end

  def render("406.json-api", _) do
    %{
      errors: [
        %{
          title: Errors.unnacceptable_type
        }
      ]
    }
  end

  def render("422.json-api", data) do
    %{
      errors: [
        %{
          title: data[:title]
        }
      ]
    }
  end

  def render("404.json-api", data) do
    %{
      errors: [
        %{
          title: data[:title]
        }
      ]
    }
  end

  def render("401.json-api", data) do
    %{
      errors: [
        %{
          title: data[:title]
        }
      ]
    }
  end

  def render(_, _) do
    %{
      errors: [
        %{
          title: "Unkown error occured"
        }
      ]
    }
  end
end
