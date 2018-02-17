defmodule MrbeekenBackend.Repo.Migrations.AddOrderToUnits do
  use Ecto.Migration

  def change do
    alter table(:units) do
      add :order_num, :integer
    end
  end
end
