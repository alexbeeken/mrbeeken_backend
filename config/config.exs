# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# General application configuration
config :mrbeeken_backend,
  ecto_repos: [MrbeekenBackend.Repo]

# Configures the endpoint
config :mrbeeken_backend, MrbeekenBackendWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "e1SXjRdgNleuQbF1qQpYR079RPbQLIZPNZ+xiuBvVyCo6tVJqT3mvhpSVLAJ6Pq+",
  render_errors: [view: MrbeekenBackendWeb.ErrorView, accepts: ~w(html json)],
  pubsub: [name: MrbeekenBackend.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

  config :mrbeeken_backend, MrbeekenBackendWeb.Repo,
    adapter: Ecto.Adapters.Postgres,
    database: "ecto_simple",
    username: "postgres",
    password: "postgres",
    hostname: "localhost",
    port: "5432"

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"
