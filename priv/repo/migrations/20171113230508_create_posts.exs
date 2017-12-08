defmodule MrbeekenBackend.Repo.Migrations.CreatePosts do
  use Ecto.Migration

  def change do
    create table(:posts) do
      add :title, :string
      add :summary, :string
      add :content, :string
      add :thumbnail, :string
      add :audio, :string

      timestamps()
    end
  end
end
