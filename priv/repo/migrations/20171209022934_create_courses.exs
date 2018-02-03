defmodule MrbeekenBackend.Repo.Migrations.CreateCourses do
  use Ecto.Migration

  alias MrbeekenBackendWeb.Unit

  def change do
    create table(:courses) do
      add :title, :string
      add :summary, :text

      timestamps()
    end

    create table(:units) do
      add :title, :string
      add :summary, :string
      add :course_id, references(:courses), null: false

      timestamps()
    end

    create table(:assessments) do
      add :title, :string
      add :unit_id, references(:units), null: false

      timestamps()
    end

    create table(:lessons) do
      add :title, :string
      add :content, :string
      add :unit_id, references(:units), null: false

      timestamps()
    end
  end
end
