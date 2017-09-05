defmodule MrbeekenBackendWeb.RegistrationController do
  use MrbeekenBackendWeb, :controller
  alias MrbeekenBackendWeb.User
  alias MrbeekenBackend.Repo

  def create(conn, %{"data" => %{"type" => "user",
  	"attributes" => %{"email" => email,
  	  "password" => password,
  	  "password_confirmation" => password_confirmation}}}) do

    changeset = User.changeset %User{}, %{email: email,
    password_confirmation: password_confirmation,
    password: password}

    case Repo.insert changeset do
      {:ok, user} ->
        conn
        |> put_status(:created)
        |> render(MrbeekenBackendWeb.UserView, "show.json", user: user)
      {:error, changeset} ->
        conn
        |> put_status(:unprocessable_entity)
        |> render(MrbeekenBackendWeb.ChangesetView, "error.json", changeset: changeset)
    end
    conn
    |> json(%{status: "Ok"})
  end
end
