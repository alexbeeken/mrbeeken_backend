defmodule MrbeekenBackendWeb.SessionController do
  use MrbeekenBackendWeb, :controller
  
  import MrbeekenBackendWeb.Authentication
  
  alias MrbeekenBackend.Repo
  alias MrbeekenBackendWeb.{User,Errors,ErrorView}

  def login(conn, params) do
    user = Repo.get_by(User, email: params["email"])
    if user do
      if Comeonin.Bcrypt.checkpw(params["password"], user.password_hash) do
        case Guardian.encode_and_sign(user) do
          {:ok, jwt, _} ->
            conn
            |> put_status(201)
            |> render("login.json-api", token: jwt)
          {:error, _, _} ->
            conn
            |> put_status(400)
            |> render(ErrorView, "400.json-api", %{title: Errors.password_bad})
        end
      else
        conn
        |> put_status(400)
        |> render(ErrorView, "400.json-api", %{title: Errors.password_bad})
      end
    else
      conn
      |> put_status(404)
      |> render(ErrorView, "404.json-api", %{title: Errors.user_not_found})
    end
  end

  def logout(conn, params) do
    token = find_token(conn.req_headers)
    case Guardian.revoke!(token) do
      :ok ->
        conn
        |> put_status(200)
        |> render("logout.json-api")
      :error ->
        conn
        |> put_status(400)
        |> render(ErrorView, "400.json-api", %{title: Errors.session_bad})
    end
  end
end
