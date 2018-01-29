defmodule IfscSearch.Repo.Migrations.CreateBranches do
  use Ecto.Migration

  def change do
    create table(:branches) do
      add :name, :string
      add :address, :text
      add :ifsc, :string
      add :contact_no, :string
      add :bank_id, references(:banks, on_delete: :nothing), null: false
      add :city_id, references(:cities, on_delete: :nothing), null: false

      timestamps()
    end

    create unique_index(:branches, [:ifsc])
    create index(:branches, [:bank_id])
    create index(:branches, [:city_id])
  end
end
