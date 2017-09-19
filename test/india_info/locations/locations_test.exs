defmodule IndiaInfo.LocationsTest do
  use IndiaInfo.DataCase

  alias IndiaInfo.Locations

  describe "states" do
    alias IndiaInfo.Locations.State

    @valid_attrs %{name: "some name"}
    @update_attrs %{name: "some updated name"}
    @invalid_attrs %{name: nil}

    def state_fixture(attrs \\ %{}) do
      {:ok, state} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Locations.create_state()

      state
    end

    test "list_states/0 returns all states" do
      state = state_fixture()
      assert Locations.list_states() == [state]
    end

    test "get_state!/1 returns the state with given id" do
      state = state_fixture()
      assert Locations.get_state!(state.id) == state
    end

    test "create_state/1 with valid data creates a state" do
      assert {:ok, %State{} = state} = Locations.create_state(@valid_attrs)
      assert state.name == "some name"
    end

    test "create_state/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Locations.create_state(@invalid_attrs)
    end

    test "update_state/2 with valid data updates the state" do
      state = state_fixture()
      assert {:ok, state} = Locations.update_state(state, @update_attrs)
      assert %State{} = state
      assert state.name == "some updated name"
    end

    test "update_state/2 with invalid data returns error changeset" do
      state = state_fixture()
      assert {:error, %Ecto.Changeset{}} = Locations.update_state(state, @invalid_attrs)
      assert state == Locations.get_state!(state.id)
    end

    test "delete_state/1 deletes the state" do
      state = state_fixture()
      assert {:ok, %State{}} = Locations.delete_state(state)
      assert_raise Ecto.NoResultsError, fn -> Locations.get_state!(state.id) end
    end

    test "change_state/1 returns a state changeset" do
      state = state_fixture()
      assert %Ecto.Changeset{} = Locations.change_state(state)
    end
  end
end
