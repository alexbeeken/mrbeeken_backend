defmodule MrbeekenBackendWeb.ErrorViewTest do
  @moduledoc """
    Generated test. Will need to be fleshed out when going over json api
    error compliance.
  """

  use MrbeekenBackendWeb.ConnCase, async: true

  # Bring render/3 and render_to_string/3 for testing custom views
  import Phoenix.View

  test "renders 404.json-api" do
    assert render_to_string(MrbeekenBackendWeb.ErrorView, "404.json-api", []) ==
           ~s({\"errors\":[{\"title\":null}]})
  end
end
