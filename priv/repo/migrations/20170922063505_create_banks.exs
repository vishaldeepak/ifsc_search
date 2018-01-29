defmodule IfscSearch.Repo.Migrations.CreateBanks do
  use Ecto.Migration

  def change do
    create table(:banks) do
      add :name, :string

      timestamps()
    end

    create unique_index(:banks, [:name])
  end
end
