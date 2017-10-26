import Ecto.Query, warn: false
alias IndiaInfo.Repo
require IEx
alias IndiaInfo.Banks.{Bank, Branch}
alias IndiaInfo.Locations.{City, District, State}
alias Ecto.Multi
alias IndiaInfo.{Banks, Locations}
alias IndiaInfo.Helpers.QueryHelper