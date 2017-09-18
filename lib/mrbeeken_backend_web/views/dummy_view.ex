defmodule MrbeekenBackendWeb.DummyView do
  use MrbeekenBackendWeb, :view

  def render("success.json-api", _data) do
    %{
        status: "ok"
     }
  end
end
