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
  render_errors: [view: MrbeekenBackendWeb.ErrorView, accepts: ~w(json-api)],
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

config :mime, :types, %{
  "application/vnd.api+json" => ["json-api"]
}

config :phoenix, :format_encoders,
  "json-api": Poison

config :ja_resource, repo: MrbeekenBackend.Repo

config :guardian, Guardian,
  allowed_algos: ["HS512"], # optional
  verify_module: Guardian.JWT,  # optional
  issuer: "MrBeeken",
  ttl: { 30, :days },
  verify_issuer: true, # optional
  secret_key: System.get_env("GUARDIAN_SECRET"),
  serializer: MrbeekenBackend.GuardianSerializer

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"
