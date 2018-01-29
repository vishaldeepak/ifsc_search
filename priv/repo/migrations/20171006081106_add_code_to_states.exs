defmodule IfscSearch.Repo.Migrations.AddCodeToStates do
  use Ecto.Migration

  def change do
    alter table("states") do
      add :code, :string, size: 2
    end
    create unique_index(:states, [:code])
  end
end
