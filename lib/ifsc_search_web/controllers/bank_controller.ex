defmodule IfscSearchWeb.BankController do
  use IfscSearchWeb, :controller

  alias IfscSearch.{Banks, Locations}
  alias IfscSearch.Banks.Bank

  def index(conn, _params) do
    banks = Banks.list_banks()
    render(conn, "index.html", banks: banks)
  end

  def all_banks(conn, _params) do
    banks = Banks.list_banks()
    render(conn, "all_banks.html", banks: banks)
  end

  def new(conn, _params) do
    changeset = Banks.change_bank(%Bank{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"bank" => bank_params}) do
    case Banks.create_bank(bank_params) do
      {:ok, bank} ->
        conn
        |> put_flash(:info, "Bank created successfully.")
        |> redirect(to: bank_path(conn, :show, bank))
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    bank = Banks.get_bank!(id)
    states = Locations.list_states([:name, :id])
    render(conn, "show.html", bank: bank, states: states)
  end

  def edit(conn, %{"id" => id}) do
    bank = Banks.get_bank!(id)
    changeset = Banks.change_bank(bank)
    render(conn, "edit.html", bank: bank, changeset: changeset)
  end

  def update(conn, %{"id" => id, "bank" => bank_params}) do
    bank = Banks.get_bank!(id)

    case Banks.update_bank(bank, bank_params) do
      {:ok, bank} ->
        conn
        |> put_flash(:info, "Bank updated successfully.")
        |> redirect(to: bank_path(conn, :show, bank))
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", bank: bank, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    bank = Banks.get_bank!(id)
    {:ok, _bank} = Banks.delete_bank(bank)

    conn
    |> put_flash(:info, "Bank deleted successfully.")
    |> redirect(to: bank_path(conn, :index))
  end
end
