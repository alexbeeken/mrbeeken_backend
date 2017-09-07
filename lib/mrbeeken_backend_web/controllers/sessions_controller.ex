require IEx
defmodule MrbeekenBackendWeb.SessionsController do
  use MrbeekenBackendWeb, :controller
  alias MrbeekenBackend.Repo
  alias MrbeekenBackendWeb.{User, Session}

  def create(conn, params) do
    user = Repo.get_by(User, email: params["username"]) |> Repo.preload(:session)
    correct_pw = Comeonin.Bcrypt.checkpw(params["password"], user.password_hash)
    session = Session.changeset(%Session{}, %{user_id: user.id})
    session = Repo.insert!(session) |> Repo.preload(:user)
    if correct_pw do
      conn
      |> put_status(200)
      |> render("show.json-api", data: session)
    else
      IO.puts("UNsuccessful LOGIN")
    end
  end
end
