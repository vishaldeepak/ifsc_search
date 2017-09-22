defmodule IndiaInfo.Banks.Bank do
  use Ecto.Schema
  import Ecto.Changeset
  alias IndiaInfo.Banks.{Bank, Branch}


  schema "banks" do
    field :name, :string

    has_many :branches, Branches

    timestamps()
  end

  @doc false
  def changeset(%Bank{} = bank, attrs) do
    bank
    |> cast(attrs, [:name])
    |> validate_required([:name])
    |> unique_constraint(:name)
  end
end
