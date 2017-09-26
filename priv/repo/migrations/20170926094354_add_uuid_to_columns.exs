defmodule IndiaInfo.Repo.Migrations.AddUuidToColumns do
  use Ecto.Migration

  def change do
    alter table("cities") do
      add :uuid, :binary_id, null: false
    end
    
    alter table("districts") do
      add :uuid, :binary_id, null: false
    end

    alter table("states") do
      add :uuid, :binary_id, null: false
    end    

    alter table("banks") do
      add :uuid, :binary_id, null: false
    end    
  end
end
