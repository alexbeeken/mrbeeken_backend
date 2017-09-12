defmodule MrbeekenBackendWeb.SessionsView do
  use MrbeekenBackendWeb, :view
  use JaSerializer.PhoenixView
  attributes [:token]

  def render("delete.json-api", _data) do
    %{
        status: "ok"
     }
  end

  def render("token.json-api", data) do
    %{
        token: data["token"]
     }
  end
end
