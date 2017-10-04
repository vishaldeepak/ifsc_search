defmodule IndiaInfo.Helpers.QueryHelper do
  import Ecto.Query

  @spec select_columns(Ecto.Query, list(:atom)) :: Ecto.Query
  def select_columns(query, select_rows) do
    case select_rows do
      nil -> query
      select_rows -> from q in query, select: struct(q, ^select_rows)
    end
  end
end