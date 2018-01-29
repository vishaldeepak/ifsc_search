defmodule IfscSearch.BanksTest do
  use IfscSearch.DataCase

  alias IfscSearch.Banks

  describe "banks" do
    alias IfscSearch.Banks.Bank

    @valid_attrs %{name: "some name"}
    @update_attrs %{name: "some updated name"}
    @invalid_attrs %{name: nil}

    def bank_fixture(attrs \\ %{}) do
      {:ok, bank} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Banks.create_bank()

      bank
    end

    test "list_banks/0 returns all banks" do
      bank = bank_fixture()
      assert Banks.list_banks() == [bank]
    end

    test "get_bank!/1 returns the bank with given id" do
      bank = bank_fixture()
      assert Banks.get_bank!(bank.id) == bank
    end

    test "create_bank/1 with valid data creates a bank" do
      assert {:ok, %Bank{} = bank} = Banks.create_bank(@valid_attrs)
      assert bank.name == "some name"
    end

    test "create_bank/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Banks.create_bank(@invalid_attrs)
    end

    test "update_bank/2 with valid data updates the bank" do
      bank = bank_fixture()
      assert {:ok, bank} = Banks.update_bank(bank, @update_attrs)
      assert %Bank{} = bank
      assert bank.name == "some updated name"
    end

    test "update_bank/2 with invalid data returns error changeset" do
      bank = bank_fixture()
      assert {:error, %Ecto.Changeset{}} = Banks.update_bank(bank, @invalid_attrs)
      assert bank == Banks.get_bank!(bank.id)
    end

    test "delete_bank/1 deletes the bank" do
      bank = bank_fixture()
      assert {:ok, %Bank{}} = Banks.delete_bank(bank)
      assert_raise Ecto.NoResultsError, fn -> Banks.get_bank!(bank.id) end
    end

    test "change_bank/1 returns a bank changeset" do
      bank = bank_fixture()
      assert %Ecto.Changeset{} = Banks.change_bank(bank)
    end
  end

  describe "branches" do
    alias IfscSearch.Banks.Branch

    @valid_attrs %{address: "some address", contact: "some contact", ifsc: "some ifsc", name: "some name"}
    @update_attrs %{address: "some updated address", contact: "some updated contact", ifsc: "some updated ifsc", name: "some updated name"}
    @invalid_attrs %{address: nil, contact: nil, ifsc: nil, name: nil}

    def branch_fixture(attrs \\ %{}) do
      {:ok, branch} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Banks.create_branch()

      branch
    end

    test "list_branches/0 returns all branches" do
      branch = branch_fixture()
      assert Banks.list_branches() == [branch]
    end

    test "get_branch!/1 returns the branch with given id" do
      branch = branch_fixture()
      assert Banks.get_branch!(branch.id) == branch
    end

    test "create_branch/1 with valid data creates a branch" do
      assert {:ok, %Branch{} = branch} = Banks.create_branch(@valid_attrs)
      assert branch.address == "some address"
      assert branch.contact == "some contact"
      assert branch.ifsc == "some ifsc"
      assert branch.name == "some name"
    end

    test "create_branch/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Banks.create_branch(@invalid_attrs)
    end

    test "update_branch/2 with valid data updates the branch" do
      branch = branch_fixture()
      assert {:ok, branch} = Banks.update_branch(branch, @update_attrs)
      assert %Branch{} = branch
      assert branch.address == "some updated address"
      assert branch.contact == "some updated contact"
      assert branch.ifsc == "some updated ifsc"
      assert branch.name == "some updated name"
    end

    test "update_branch/2 with invalid data returns error changeset" do
      branch = branch_fixture()
      assert {:error, %Ecto.Changeset{}} = Banks.update_branch(branch, @invalid_attrs)
      assert branch == Banks.get_branch!(branch.id)
    end

    test "delete_branch/1 deletes the branch" do
      branch = branch_fixture()
      assert {:ok, %Branch{}} = Banks.delete_branch(branch)
      assert_raise Ecto.NoResultsError, fn -> Banks.get_branch!(branch.id) end
    end

    test "change_branch/1 returns a branch changeset" do
      branch = branch_fixture()
      assert %Ecto.Changeset{} = Banks.change_branch(branch)
    end
  end
end
