defmodule MrbeekenBackendWeb.SessionsController do
  use MrbeekenBackendWeb, :controller
  alias MrbeekenBackend.Repo
  alias MrbeekenBackendWeb.{User,Session,Errors,ErrorView}

  def create(conn, params) do
    user = Repo.get_by(User, email: params["username"])
    unless Comeonin.Bcrypt.checkpw(params["password"], user.password_hash) do
      conn
      |> put_status(400)
      |> render(MrbeekenBackendWeb.ErrorView, "400.json-api", %{title: Errors.password_bad})
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

  def delete(conn, params) do
    session = Repo.get_by(Session, token: params["token"])
    if session do
      Repo.delete!(session)
      conn
      |> put_status(200)
      |> render("delete.json-api")
    else
      conn
      |> put_status(400)
      |> render(MrbeekenBackendWeb.ErrorView, "400.json-api", %{title: Errors.session_bad})
    end
  end
end
