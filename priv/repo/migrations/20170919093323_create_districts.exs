defmodule IndiaInfo.Repo.Migrations.CreateDistricts do
  use Ecto.Migration

  def change do
    create table(:districts) do
      add :name, :string
      add :state_id, references(:states, on_delete: :nothing), null: false

      timestamps()
    end

    create index(:districts, [:state_id])
  end
end
