defmodule IfscSearch.Repo.Migrations.AddUnqueNameState do
  use Ecto.Migration

  def change do
    create unique_index("states", [:name])
    create unique_index("districts", [:name, :state_id])
    create unique_index("cities", [:name, :district_id])
  end
end
