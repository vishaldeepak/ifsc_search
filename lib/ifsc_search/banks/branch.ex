defmodule IfscSearch.Banks.Branch do
  use Ecto.Schema
  import Ecto.Changeset
  import Ecto.Query, warn: false
  alias IfscSearch.Banks.{Bank, Branch}
  alias IfscSearch.Locations.District


  schema "branches" do
    field :address, :string
    field :contact_no, :string
    field :ifsc, :string
    field :micr, :string
    field :name, :string
    field :city_name, :string
    field :tags, {:array, :string}

    belongs_to :bank, Bank
    belongs_to :district, District

    timestamps()
  end

  @doc false
  def changeset(%Branch{} = branch, attrs) do
    branch
    |> cast(attrs, [:name, :address, :ifsc, :contact_no, :bank_id, :district_id, :city_name, :micr])
    |> validate_required([:name, :address, :ifsc, :contact_no, :bank_id, :district_id, :city_name])
    |> unique_constraint(:ifsc)
  end

  def search_in_state(query, state_id) do
    query
    |> join(:left, [b], d in District, b.district_id == d.id)
    |> where([b, d], d.state_id == ^state_id)
  end
end
