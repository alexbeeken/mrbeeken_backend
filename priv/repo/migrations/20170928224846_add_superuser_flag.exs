defmodule MrbeekenBackend.Repo.Migrations.AddSuperuserFlag do
  use Ecto.Migration

  def change do
    alter table(:users) do
      add :superuser, :boolean
    end
  end
end
