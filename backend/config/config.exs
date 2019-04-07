# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :grumpy_cat,
  ecto_repos: [GrumpyCat.Repo]

# Configures the endpoint
config :grumpy_cat, GrumpyCatWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "3bU5laL/LszFOL3GgOQKt9xwrOJRKfiYH2s6QgX41WnazhdGMcrJ4b676bRF7PIW",
  render_errors: [view: GrumpyCatWeb.ErrorView, accepts: ~w(json)],
  pubsub: [name: GrumpyCat.PubSub, adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
