defmodule IndiaInfo.Locations.City do
  use Ecto.Schema
  import Ecto.Changeset
  alias IndiaInfo.Locations.City


  schema "cities" do
    field :name, :string
    
    belongs_to :district, IndiaInfo.Locations.District

    timestamps()
  end

  @doc false
  def changeset(%City{} = city, attrs) do
    city
    |> cast(attrs, [:name, :district_id])
    |> validate_required([:name, :district_id])
  end
end
