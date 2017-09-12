defmodule MrbeekenBackendWeb.SessionsController do
  use MrbeekenBackendWeb, :controller
  alias MrbeekenBackend.Repo
  alias MrbeekenBackendWeb.{User,Session,Errors,ErrorView}

  def token(conn, params) do
    user = Repo.get_by(User, email: params["username"])
    unless Comeonin.Bcrypt.checkpw(params["password"], user.password_hash) do
      conn
      |> put_status(400)
      |> render(MrbeekenBackendWeb.ErrorView, "400.json-api", %{title: Errors.password_bad})
    else
      case Guardian.encode_and_sign(user) do
       {:ok, jwt, _} ->
         conn
         |> put_status(201)
         |> render("token.json-api", data: %{token: jwt})
       {:error, _, _} ->
         conn
         |> put_status(400)
         |> render(MrbeekenBackendWeb.ErrorView, "400.json-api", %{title: Errors.password_bad})
         |> Poison.encode!
      end
    end
  end

  def delete(conn, params) do
    case Guardian.revoke(params["token"]) do
      {:ok, _} ->
        conn
        |> put_status(200)
        |> render("delete.json-api")
      {:error, _} ->
        conn
        |> put_status(400)
        |> render(MrbeekenBackendWeb.ErrorView, "400.json-api", %{title: Errors.session_bad})
    end
  end
end
