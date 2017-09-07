defmodule MrbeekenBackend.Repo.Migrations.CreateSessions do
  use Ecto.Migration

  def change do
    create table(:users) do
      add :token, :string
      add :user_id, references(:users)

      timestamps()
    end
  end
end
