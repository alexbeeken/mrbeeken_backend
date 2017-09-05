defmodule MrbeekenBackendWeb.SessionController do
  use MrbeekenBackendWeb, :controller
  alias MrbeekenBackend.Repo

  def index(conn, _params) do
    conn
    |> json(%{status: "Ok"})
  end
end
