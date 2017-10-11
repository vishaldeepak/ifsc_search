defmodule IndiaInfo.Helpers.QueryHelper do
  import Ecto.Query

  @spec select_columns(Ecto.Query, list(:atom)) :: Ecto.Query
  def select_columns(query, select_rows) do
    case select_rows do
      nil -> query
      select_rows -> from q in query, select: struct(q, ^select_rows)
    end
  end

  @spec search_document(Ecto.Query, String) :: Ecto.Query
  def search_document(query, search_term) do
    query
    |> where([q], fragment("? @@ to_tsquery('simple', ?)", q.document, ^parse_terms_for_document(search_term)))
  end

  defp parse_terms_for_document(search_term) do
    search_term
    |> String.replace(~r/\w+:["'].+?["']/, "")
    |> String.split()
    |> Enum.uniq
    |> Enum.map(&("#{&1}:*"))
    |> Enum.join(" & ")
  end
end