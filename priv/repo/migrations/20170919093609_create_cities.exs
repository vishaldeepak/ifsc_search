defmodule IndiaInfo.Repo.Migrations.CreateCities do
  use Ecto.Migration

  def change do
    create table(:cities) do
      add :name, :string
      add :district_id, references(:districts, on_delete: :nothing), null: false

      timestamps()
    end

    create index(:cities, [:district_id])
  end
end
