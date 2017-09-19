defmodule IndiaInfo.Locations.City do
  use Ecto.Schema
  import Ecto.Changeset
  alias IndiaInfo.Locations.City


  schema "cities" do
    field :name, :string
    field :district_id, :id

    timestamps()
  end

  @doc false
  def changeset(%City{} = city, attrs) do
    city
    |> cast(attrs, [:name])
    |> validate_required([:name])
  end
end
