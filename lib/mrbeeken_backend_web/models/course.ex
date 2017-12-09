defmodule MrbeekenBackendWeb.Course do
  use Ecto.Schema
  import Ecto.Changeset

  schema "courses" do
    field :title, :string
    field :summary, :string
    has_many :units, MrbeekenBackendWeb.Unit

    timestamps()
  end

  @required_fields ~w(title summary)a

  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, @required_fields)
    |> validate_required(@required_fields)
  end
end
