defmodule MrbeekenBackendWeb.Lesson do
  use Ecto.Schema
  import Ecto.Changeset

  schema "lessons" do
    field :title, :string
    field :content, :string
    belongs_to :unit, MrbeekenBackendWeb.Unit

    timestamps()
  end

  @required_fields ~w(title content unit_id)a

  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, @required_fields)
    |> validate_required(@required_fields)
    |> assoc_constraint(:unit)
  end
end
