defmodule IfscSearch.LocationsTest do
  use IfscSearch.DataCase

  alias IfscSearch.Locations

  describe "states" do
    alias IfscSearch.Locations.State

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

  describe "districts" do
    alias IfscSearch.Locations.District

    @valid_attrs %{name: "some name"}
    @update_attrs %{name: "some updated name"}
    @invalid_attrs %{name: nil}

    def district_fixture(attrs \\ %{}) do
      {:ok, district} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Locations.create_district()

      district
    end

    test "list_districts/0 returns all districts" do
      district = district_fixture()
      assert Locations.list_districts() == [district]
    end

    test "get_district!/1 returns the district with given id" do
      district = district_fixture()
      assert Locations.get_district!(district.id) == district
    end

    test "create_district/1 with valid data creates a district" do
      assert {:ok, %District{} = district} = Locations.create_district(@valid_attrs)
      assert district.name == "some name"
    end

    test "create_district/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Locations.create_district(@invalid_attrs)
    end

    test "update_district/2 with valid data updates the district" do
      district = district_fixture()
      assert {:ok, district} = Locations.update_district(district, @update_attrs)
      assert %District{} = district
      assert district.name == "some updated name"
    end

    test "update_district/2 with invalid data returns error changeset" do
      district = district_fixture()
      assert {:error, %Ecto.Changeset{}} = Locations.update_district(district, @invalid_attrs)
      assert district == Locations.get_district!(district.id)
    end

    test "delete_district/1 deletes the district" do
      district = district_fixture()
      assert {:ok, %District{}} = Locations.delete_district(district)
      assert_raise Ecto.NoResultsError, fn -> Locations.get_district!(district.id) end
    end

    test "change_district/1 returns a district changeset" do
      district = district_fixture()
      assert %Ecto.Changeset{} = Locations.change_district(district)
    end
  end

  describe "cities" do
    alias IfscSearch.Locations.City

    @valid_attrs %{name: "some name"}
    @update_attrs %{name: "some updated name"}
    @invalid_attrs %{name: nil}

    def city_fixture(attrs \\ %{}) do
      {:ok, city} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Locations.create_city()

      city
    end

    test "list_cities/0 returns all cities" do
      city = city_fixture()
      assert Locations.list_cities() == [city]
    end

    test "get_city!/1 returns the city with given id" do
      city = city_fixture()
      assert Locations.get_city!(city.id) == city
    end

    test "create_city/1 with valid data creates a city" do
      assert {:ok, %City{} = city} = Locations.create_city(@valid_attrs)
      assert city.name == "some name"
    end

    test "create_city/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Locations.create_city(@invalid_attrs)
    end

    test "update_city/2 with valid data updates the city" do
      city = city_fixture()
      assert {:ok, city} = Locations.update_city(city, @update_attrs)
      assert %City{} = city
      assert city.name == "some updated name"
    end

    test "update_city/2 with invalid data returns error changeset" do
      city = city_fixture()
      assert {:error, %Ecto.Changeset{}} = Locations.update_city(city, @invalid_attrs)
      assert city == Locations.get_city!(city.id)
    end

    test "delete_city/1 deletes the city" do
      city = city_fixture()
      assert {:ok, %City{}} = Locations.delete_city(city)
      assert_raise Ecto.NoResultsError, fn -> Locations.get_city!(city.id) end
    end

    test "change_city/1 returns a city changeset" do
      city = city_fixture()
      assert %Ecto.Changeset{} = Locations.change_city(city)
    end
  end
end
