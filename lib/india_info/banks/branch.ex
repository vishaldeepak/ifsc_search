defmodule IndiaInfo.Banks.Branch do
  use Ecto.Schema
  import Ecto.Changeset
  import Ecto.Query, warn: false
  alias IndiaInfo.Banks.{Bank, Branch}
  alias IndiaInfo.Locations.District
  alias IndiaInfo.Repo


  schema "branches" do
    field :address, :string
    field :contact_no, :string
    field :ifsc, :string
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
    |> cast(attrs, [:name, :address, :ifsc, :contact_no, :bank_id, :district_id, :city_name])
    |> validate_required([:name, :address, :ifsc, :contact_no, :bank_id, :district_id, :city_name])
    |> unique_constraint(:ifsc)
  end

  def search_in_state(query, state_id) do
    query
    |> join(:left, [b], d in District, b.district_id == d.id)
    |> where([b, d], d.state_id == ^state_id)
  end
end
