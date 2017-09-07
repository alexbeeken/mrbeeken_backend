defmodule MrbeekenBackendWeb.SessionsView do
  use MrbeekenBackendWeb, :view
  use JaSerializer.PhoenixView
  attributes [:token]
end
