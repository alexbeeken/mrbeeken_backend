defmodule MrbeekenBackend.Repo.Migrations.CreateActivities do
  use Ecto.Migration

  def change do
    alter table(:assessments) do
      add :order, :integer
    end

    alter table(:lessons) do
      add :order, :integer
    end
  end
end
