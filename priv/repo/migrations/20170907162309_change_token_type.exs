defmodule MrbeekenBackend.Repo.Migrations.ChangeTokenType do
  use Ecto.Migration

  def change do
    alter table(:sessions) do
      modify :token, :text
    end
  end
end
