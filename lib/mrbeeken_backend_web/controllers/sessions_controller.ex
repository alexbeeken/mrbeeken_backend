defmodule MrbeekenBackendWeb.SessionsController do
  use MrbeekenBackendWeb, :controller
  alias MrbeekenBackend.Repo
  alias MrbeekenBackendWeb.{User, Session}

  def create(conn, params) do
    user = Repo.get_by(User, email: params["username"]) |> Repo.preload(:session)
    unless Comeonin.Bcrypt.checkpw(params["password"], user.password_hash) do
      conn
      |> put_status(400)
      |> render(:errors, %{errors: [%{title: "bad password"}]})
    else
      changeset = Session.changeset(%Session{}, %{user_id: user.id})
      case Repo.insert(changeset) do
       {:ok, session} ->
         conn
         |> put_status(201)
         |> render("show.json-api", data: session)
       {:error, changeset} ->
         conn
         |> put_status(400)
         |> JaSerializer.EctoErrorSerializer.format(changeset)
         |> Poison.encode!
      end
    end
  end
end
