defmodule IndiaInfo.Locations.State do
  use Ecto.Schema
  import Ecto.Changeset
  alias IndiaInfo.Locations.State


  schema "states" do
    field :name, :string

    timestamps()
  end

  @doc false
  def changeset(%State{} = state, attrs) do
    state
    |> cast(attrs, [:name])
    |> validate_required([:name])
  end
end
