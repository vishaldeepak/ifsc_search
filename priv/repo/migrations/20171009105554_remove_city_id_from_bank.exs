defmodule IfscSearch.Repo.Migrations.RemoveCityIdFromBank do
  use Ecto.Migration

  def change do
    alter table("branches") do
      remove :city_id
      add :district_id, references(:districts, on_delete: :nothing), null: false
      add :city_name, :string
    end

    create index(:branches, [:district_id])
  end
end
