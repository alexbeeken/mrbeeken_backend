defmodule MrbeekenBackendWeb.SessionController do
  use MrbeekenBackendWeb, :controller

  import MrbeekenBackendWeb.Authentication

  alias MrbeekenBackend.Repo
  alias MrbeekenBackendWeb.{User, Errors, ErrorView}

  def login(conn, params) do
    user = Repo.get_by(User, email: params["email"])
    unless user, do: Errors.render_error(conn, 404, Errors.user_not_found)
    if password_correct?(user, params["password"]) do
      generate_token(conn, user)
    else
      Errors.render_error(conn, 404, Errors.password_bad)
    end
  end

  def generate_token(conn, user) do
    case Guardian.encode_and_sign(user) do
      {:ok, jwt, _} ->
        conn
        |> put_status(201)
        |> render("login.json-api", token: jwt)
      {:error, _, _} ->
        Errors.render_error(conn, 404, Errors.password_bad)
    end
  end

  def password_correct?(user, password) do
    Comeonin.Bcrypt.checkpw(password, user.password_hash)
  end

  def logout(conn, params) do
    token = find_token(conn.req_headers)
    case Guardian.revoke!(token) do
      :ok ->
        conn
        |> put_status(200)
        |> render("logout.json-api")
      :error ->
        Errors.render_error(conn, 400, Errors.session_bad)
    end
  end
end
