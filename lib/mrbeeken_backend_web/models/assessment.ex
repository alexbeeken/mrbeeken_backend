defmodule MrbeekenBackendWeb.Assessment do
  use Ecto.Schema
  import Ecto.Changeset

  schema "assessments" do
    field :title, :string
    belongs_to :unit, MrbeekenBackendWeb.Unit

    timestamps()
  end

  @required_fields ~w(title unit_id)a

  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, @required_fields)
    |> validate_required(@required_fields)
    |> assoc_constraint(:unit)
  end
end
