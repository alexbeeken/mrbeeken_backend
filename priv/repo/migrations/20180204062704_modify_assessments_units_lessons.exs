defmodule MrbeekenBackend.Repo.Migrations.ModifyAssessmentsUnitsLessons do
  use Ecto.Migration

  def change do
    alter table(:units) do
      remove :course_id
      add :course_id, references(:courses, on_delete: :nilify_all)
    end

    alter table(:assessments) do
      remove :unit_id
      add :unit_id, references(:units, on_delete: :nilify_all)
    end

    alter table(:lessons) do
      remove :unit_id
      add :unit_id, references(:units, on_delete: :nilify_all)
    end
  end
end
