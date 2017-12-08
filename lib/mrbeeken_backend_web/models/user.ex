defmodule MrbeekenBackendWeb.User do
  use Ecto.Schema
  import Ecto.Changeset

  schema "users" do
    field :email, :string
    field :password, :string, virtual: true
    field :password_confirmation, :string, virtual: true
    field :password_hash, :string
    field :superuser, :boolean, default: false

    timestamps()
  end

  @required_fields ~w(email password password_confirmation)a
  @optional_fields ~w(superuser)a

  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, @required_fields)
    |> cast(params, @optional_fields)
    |> validate_format(:email, ~r/@/)
    |> validate_required(@required_fields)
    |> validate_length(:password, min: 8)
    |> validate_confirmation(:password)
    |> hash_password
    |> unique_constraint(:email)
  end

  defp hash_password(%{valid?: false} = changeset), do: changeset
  defp hash_password(%{valid?: true} = changeset) do
    hashedpw =
      Comeonin.Bcrypt.hashpwsalt(Ecto.Changeset.get_field(changeset, :password))
    Ecto.Changeset.put_change(changeset, :password_hash, hashedpw)
  end
end
