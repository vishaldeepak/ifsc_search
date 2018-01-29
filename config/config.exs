# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# General application configuration
config :ifsc_search,
  ecto_repos: [IfscSearch.Repo]

# Configures the endpoint
config :ifsc_search, IfscSearchWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "boM5Zrg/aC/07fmSJXtGhE99UPTRlYAA6xJ68c09z/STCMu//IYFUgQh1AhBE+gY",
  render_errors: [view: IfscSearchWeb.ErrorView, accepts: ~w(html json)],
  pubsub: [name: IfscSearch.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"
