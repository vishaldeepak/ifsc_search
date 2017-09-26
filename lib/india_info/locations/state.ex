defmodule IndiaInfo.Locations.State do
  use Ecto.Schema
  import Ecto.Changeset
  alias IndiaInfo.Locations.State
  alias IndiaInfo.Helpers.ChangesetHelper

  schema "states" do
    field :name, :string
    field :uuid, :binary_id

    timestamps()
  end

  @doc false
  def changeset(%State{} = state, attrs) do
    state
    |> cast(attrs, [:name])
    |> validate_required([:name])
    |> unique_constraint(:name)
    |> ChangesetHelper.set_uuid()
  end
end
