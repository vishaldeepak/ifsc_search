defmodule IndiaInfo.Locations.District do
  use Ecto.Schema
  import Ecto.{Changeset, Query}
  alias IndiaInfo.Helpers.ChangesetHelper
  alias IndiaInfo.Locations.{City, District, State}

  schema "districts" do
    field :name, :string
    field :uuid, :binary_id

    belongs_to :state, State
    has_many :cities, City

    timestamps()
  end

  def select_columns(query, select_rows) do
    case select_rows do
      nil -> query
      select_rows -> from d in query, select: struct(d, ^select_rows)
    end
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
