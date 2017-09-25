defmodule IndiaInfo.Banks.Branch do
  use Ecto.Schema
  import Ecto.Changeset
  alias IndiaInfo.Banks.{Bank, Branch}
  alias IndiaInfo.Locations.City


  schema "branches" do
    field :address, :string
    field :contact_no, :string
    field :ifsc, :string
    field :name, :string
    
    belongs_to :bank, Bank
    belongs_to :city, City

    timestamps()
  end

  @doc false
  def changeset(%Branch{} = branch, attrs) do
    branch
    |> cast(attrs, [:name, :address, :ifsc, :contact_no, :bank_id, :city_id])
    |> validate_required([:name, :address, :ifsc, :contact_no, :bank_id, :city_id])
    |> unique_constraint(:ifsc)
  end
end
