defmodule IfscSearch.Banks.Bank do
  use Ecto.Schema
  import Ecto.Changeset
  alias IfscSearch.Banks.{Bank, Branch}
  alias IfscSearch.Helpers.ChangesetHelper

  schema "banks" do
    field :name, :string
    field :uuid, :binary_id

    has_many :branches, Branch

    timestamps()
  end

  @doc false
  def changeset(%Bank{} = bank, attrs) do
    bank
    |> cast(attrs, [:name])
    |> validate_required([:name])
    |> update_change(:name, &(String.downcase(&1)))
    |> unique_constraint(:name)
    |> ChangesetHelper.set_uuid()
  end
end
