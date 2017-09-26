defmodule IndiaInfo.Locations.City do
  use Ecto.Schema
  import Ecto.Changeset
  alias IndiaInfo.Locations.City
  alias IndiaInfo.Helpers.ChangesetHelper

  schema "cities" do
    field :name, :string
    field :uuid, :binary_id
    
    belongs_to :district, IndiaInfo.Locations.District

    timestamps()
  end

  @doc false
  def changeset(%City{} = city, attrs) do
    city
    |> cast(attrs, [:name, :district_id])
    |> validate_required([:name, :district_id])
    |> unique_constraint(:name, [name: :cities_name_district_id_index])
    |> ChangesetHelper.set_uuid()
  end
end
