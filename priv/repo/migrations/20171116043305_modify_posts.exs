defmodule MrbeekenBackend.Repo.Migrations.ModifyPosts do
  use Ecto.Migration

  def change do
    alter table(:posts) do
      modify :title, :text
      modify :summary, :text
      modify :content, :text
      modify :thumbnail, :text
      modify :audio, :text
    end
  end
end
