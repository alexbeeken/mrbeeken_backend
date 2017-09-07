defmodule MrbeekenBackendWeb.ErrorViewTest do
  use MrbeekenBackendWeb.ConnCase, async: true

  # Bring render/3 and render_to_string/3 for testing custom views
  import Phoenix.View

  test "renders 404.json-api" do
    assert render_to_string(MrbeekenBackendWeb.ErrorView, "404.json-api", []) ==
           "{\"errors\":[{\"title\":\"route not found\"}]}"
  end
end
