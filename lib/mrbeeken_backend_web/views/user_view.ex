defmodule MrbeekenBackendWeb.UserView do
  use JaSerializer.PhoenixView
  attributes [:email]

  def render("current.json-api", data) do
    current_user = data[:data]
    Poison.encode!(%{data: %{attributes: %{email: current_user.email}, type: "current-user"}})
  end
end
