defmodule MrbeekenBackend.Repo.Migrations.DeleteSessions do
  use Ecto.Migration

  def change do
    drop table(:sessions)
  end
end
