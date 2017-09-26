defmodule IndiaInfo.Banks.Bank do
  use Ecto.Schema
  import Ecto.Changeset
  alias IndiaInfo.Banks.{Bank, Branch}
  alias IndiaInfo.Helpers.ChangesetHelper

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
    |> unique_constraint(:name)
    |> ChangesetHelper.set_uuid()
  end
end
