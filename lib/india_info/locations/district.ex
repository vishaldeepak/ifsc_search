defmodule IndiaInfo.Locations.District do
  use Ecto.Schema
  import Ecto.Changeset
  alias IndiaInfo.Locations.District


  schema "districts" do
    field :name, :string
    
    belongs_to :state, IndiaInfo.Locations.State

    timestamps()
  end

  @doc false
  def changeset(%District{} = district, attrs) do
    district
    |> cast(attrs, [:name, :state_id])
    |> validate_required([:name, :state_id])
  end
end 
