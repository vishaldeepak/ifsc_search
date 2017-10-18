defmodule IndiaInfo.Banks do
  @moduledoc """
  The Banks context.
  """

  import Ecto.Query, warn: false
  alias IndiaInfo.Repo
  alias IndiaInfo.Banks.{Bank, Branch}
  alias IndiaInfo.Locations.District
  alias IndiaInfo.Helpers.QueryHelper

  alias Ecto.Multi

  @doc """
  Returns the list of banks.

  ## Examples

      iex> list_banks()
      [%Bank{}, ...]

  """
  def list_banks(selections \\ nil) do
    Bank
    |> QueryHelper.select_columns(selections)
    |> Repo.all
  end

  @doc """
  Gets a single bank.

  Raises `Ecto.NoResultsError` if the Bank does not exist.

  ## Examples

      iex> get_bank!(123)
      %Bank{}

      iex> get_bank!(456)
      ** (Ecto.NoResultsError)

  """
  def get_bank!(id), do: Repo.get!(Bank, id)

  def get_branch_by_ifsc(ifsc) do
    Repo.get_by(Branch, ifsc: ifsc)
  end

  @doc """
  Creates a bank.

  ## Examples

      iex> create_bank(%{field: value})
      {:ok, %Bank{}}

      iex> create_bank(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def find_or_create_bank_by_name(name) do
    case Repo.get_by(Bank, name: name) do
      nil -> create_bank(%{name: name})
      bank -> {:ok, bank}
    end
  end

  def create_bank(attrs \\ %{}) do
    %Bank{}
    |> Bank.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a bank.

  ## Examples

      iex> update_bank(bank, %{field: new_value})
      {:ok, %Bank{}}

      iex> update_bank(bank, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_bank(%Bank{} = bank, attrs) do
    bank
    |> Bank.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a Bank.

  ## Examples

      iex> delete_bank(bank)
      {:ok, %Bank{}}

      iex> delete_bank(bank)
      {:error, %Ecto.Changeset{}}

  """
  def delete_bank(%Bank{} = bank) do
    Repo.delete(bank)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking bank changes.

  ## Examples

      iex> change_bank(bank)
      %Ecto.Changeset{source: %Bank{}}

  """
  def change_bank(%Bank{} = bank) do
    Bank.changeset(bank, %{})
  end


  @doc """
  Returns the list of branches.

  ## Examples

      iex> list_branches()
      [%Branch{}, ...]

  """
  def list_branches do
    Repo.all(Branch)
  end

  @doc """
  Gets a single branch.

  Raises `Ecto.NoResultsError` if the Branch does not exist.

  ## Examples

      iex> get_branch!(123)
      %Branch{}

      iex> get_branch!(456)
      ** (Ecto.NoResultsError)

  """
  def get_branch!(id), do: Repo.get!(Branch, id) |> Repo.preload(district: :state)

  @doc """
  Creates a branch.

  ## Examples

      iex> create_branch(%{field: value})
      {:ok, %Branch{}}

      iex> create_branch(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_branch(attrs) do
    attrs
    |> create_branch_transaction()
    |> Repo.transaction
  end

  defp create_branch_transaction(attrs) do
    Multi.new
    |> Multi.run(:insert, fn _ -> insert_branch(attrs) end)
    |> Multi.run(:update, &update_branch_tags_document/1)
  end

  defp insert_branch(attrs) do
    %Branch{}
    |> Branch.changeset(attrs)
    |> Repo.insert()
  end

  defp update_branch_tags_document(%{insert: branch}) do
    district =
      District
      |> Repo.get(branch.district_id)
      |> Repo.preload(:state)

    bank_uuid = Repo.get(Bank, branch.bank_id).uuid
    tags = [district.uuid, district.state.uuid, bank_uuid]

    a_text = branch.name
    b_text =
      [branch.address, branch.city_name, district.name, district.state.name]
      |> Enum.map(&(String.split(&1)))
      |> List.flatten
      |> Enum.uniq
      |> Enum.filter(&(&1))
      |> Enum.join(" ")

    query = from(b in Branch, where: b.id == ^branch.id, update: [set:
      [tags: ^tags,
      document: fragment("setweight(to_tsvector('simple', ?), 'A') || setweight(to_tsvector('simple', ?), 'B')", ^a_text, ^b_text)]])
    Repo.update_all(query, [])
    {:ok, branch}
  end

  @doc """
  Updates a branch.

  ## Examples

      iex> update_branch(branch, %{field: new_value})
      {:ok, %Branch{}}

      iex> update_branch(branch, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_branch(%Branch{} = branch, attrs) do
    branch
    |> Branch.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a Branch.

  ## Examples

      iex> delete_branch(branch)
      {:ok, %Branch{}}

      iex> delete_branch(branch)
      {:error, %Ecto.Changeset{}}

  """
  def delete_branch(%Branch{} = branch) do
    Repo.delete(branch)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking branch changes.

  ## Examples

      iex> change_branch(branch)
      %Ecto.Changeset{source: %Branch{}}

  """
  def change_branch(%Branch{} = branch) do
    Branch.changeset(branch, %{})
  end

  def branch_search(bank_id, search_term, state_id) do
    Branch
    |> QueryHelper.search_document(search_term)
    |> where([q], q.bank_id == ^bank_id)
    |> Branch.search_in_state(state_id)
    |> limit(100)
    |> Repo.all
  end
end
