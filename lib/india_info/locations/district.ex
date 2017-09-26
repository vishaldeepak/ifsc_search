defmodule IndiaInfo.Locations.District do
  use Ecto.Schema
  import Ecto.Changeset
  alias IndiaInfo.Locations.District
  alias IndiaInfo.Helpers.ChangesetHelper

  schema "districts" do
    field :name, :string
    field :uuid, :binary_id
    
    belongs_to :state, IndiaInfo.Locations.State

    timestamps()
  end

  @doc false
  def changeset(%District{} = district, attrs) do
    district
    |> cast(attrs, [:name, :state_id])
    |> validate_required([:name, :state_id])
    |> unique_constraint(:name, [name: :districts_name_state_id_index])
    |> ChangesetHelper.set_uuid()
  end
end 
