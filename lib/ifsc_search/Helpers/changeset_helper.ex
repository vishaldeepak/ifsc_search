defmodule IfscSearch.Helpers.ChangesetHelper do
  import Ecto.Changeset

  @spec set_uuid(Ecto.Changeset) :: Ecto.Changeset
  def set_uuid(changeset) do
    case changeset |> get_field(:uuid) do
      nil -> put_change(changeset, :uuid, Ecto.UUID.generate)
      _ -> changeset
    end
  end
end
