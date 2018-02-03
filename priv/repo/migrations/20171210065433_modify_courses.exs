defmodule MrbeekenBackend.Repo.Migrations.ModifyCourses do
  use Ecto.Migration

  def change do
    alter table(:courses) do
      modify :title, :text
      modify :summary, :text
    end
  end
end
