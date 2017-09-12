defmodule MrbeekenBackendWeb.DummyView do
  use MrbeekenBackendWeb, :view

  def render("show.json-api", _data) do
    %{
        status: "ok"
     }
  end

  def render("error.json-api", data) do
    %{
        status: "error"
     }
  end
end
