import Ecto.Query, warn: false
alias IfscSearch.Repo
require IEx
alias IfscSearch.Banks.{Bank, Branch}
alias IfscSearch.Locations.{City, District, State}
alias Ecto.Multi
alias IfscSearch.{Banks, Locations}
alias IfscSearch.Helpers.QueryHelper
