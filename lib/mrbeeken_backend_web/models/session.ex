defmodule MrbeekenBackendWeb.Session do
  use Ecto.Schema
  import Ecto.Changeset
  alias MrbeekenBackend.Repo
  alias MrbeekenBackendWeb.User

  schema "sessions" do
    field :token, :string
    belongs_to :user, User

    timestamps()
  end

  def changeset(session, attrs \\ %{}) do
    user = Repo.get(User, attrs[:user_id])
    {:ok, jwt, _} = Guardian.encode_and_sign(user)
    session
    |> cast(attrs, [:user_id, :token])
    |> put_change(:token, jwt)
    |> validate_required([:user_id])
  end
end
