defmodule IndiaInfo.Repo.Migrations.AddSearchColumnsToBranch do
  use Ecto.Migration

  def up do
    alter table("branches") do
      add :tags, {:array, :string}, default: "{}", null: false
      add :document, :tsvector
    end
    create index(:branches, :tags, name: :branches_tags_index_gin, using: "GIN")
    create index(:branches, :document, name: :branches_document_index_gin, using: "GIN")
  end

  def down do
    alter table("branches") do
      remove :tags
      remove :document
    end
  end
end 
