defmodule IfscSearch.Repo.Migrations.AddMicrToBranch do
  use Ecto.Migration

  def change do
    alter table("branches") do
      add :micr, :string
    end
  end
end
