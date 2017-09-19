defmodule IndiaInfo.Locations.District do
  use Ecto.Schema
  import Ecto.Changeset
  alias IndiaInfo.Locations.District


  schema "districts" do
    field :name, :string
    field :state_id, :id

    timestamps()
  end

  @doc false
  def changeset(%District{} = district, attrs) do
    district
    |> cast(attrs, [:name])
    |> validate_required([:name])
  end
end
