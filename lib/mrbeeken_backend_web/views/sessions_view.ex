require IEx
defmodule MrbeekenBackendWeb.SessionsView do
  use MrbeekenBackendWeb, :view
  use JaSerializer.PhoenixView
  attributes [:token]

  def render("logout.json-api", _data) do
    %{
        status: "ok"
     }
  end

  def render("login.json-api", data) do
    %{
        token: data[:token]
     }
  end
end
