defmodule MrbeekenBackendWeb.Unit do
  use Ecto.Schema
  import Ecto.Changeset

  schema "units" do
    field :title, :string
    field :summary, :string
    field :order_num, :integer
    belongs_to :course, MrbeekenBackendWeb.Course
    has_many :lessons, MrbeekenBackendWeb.Lesson
    has_many :assessment, MrbeekenBackendWeb.Assessment

    timestamps()
  end

  @required_fields ~w(title summary order_num course_id)a

  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, @required_fields)
    |> validate_required(@required_fields)
    |> assoc_constraint(:course)
  end
end
