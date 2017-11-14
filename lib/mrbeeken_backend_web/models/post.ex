defmodule MrbeekenBackendWeb.Post do
  use Ecto.Schema
  import Ecto.Changeset

  schema "posts" do
    field :title, :string
    field :summary, :string
    field :content, :string
    field :thumbnail, :string
    field :audio, :string

    timestamps()
  end

  @required_fields ~w(title content)a
  @optional_fields ~w(summary thumbnail audio)a

  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, @required_fields)
    |> cast(params, @optional_fields)
    |> validate_required(@required_fields)
  end
end
