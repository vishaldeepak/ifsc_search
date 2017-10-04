defmodule IndiaInfo.Locations.State do
  use Ecto.Schema
  import Ecto.Changeset
  alias IndiaInfo.Locations.State
  alias IndiaInfo.Helpers.ChangesetHelper

  schema "states" do
    field :name, :string
    field :uuid, :binary_id
    field :code, :string, size: 2

    has_many :districts, IndiaInfo.Locations.District
    has_many :cities, through: [:districts, :cities]
    timestamps()
  end

  @doc false
  def changeset(%State{} = state, attrs) do
    state
    |> cast(attrs, [:name, :code])
    |> validate_required([:name])
    |> validate_length(:code, is: 2)
    |> update_change(:code, &(String.upcase(&1)))
    |> unique_constraint(:name)
    |> unique_constraint(:code)
    |> ChangesetHelper.set_uuid()
  end
end
