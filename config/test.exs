use Mix.Config

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :mrbeeken_backend, MrbeekenBackendWeb.Endpoint,
  http: [port: 4001],
  server: false

# Print only warnings and errors during test
config :logger,
  level: :warn,
  compile_time_purge_level: :debug

# Configure your database
config :mrbeeken_backend, MrbeekenBackend.Repo,
  adapter: Ecto.Adapters.Postgres,
  username: "postgres",
  password: "postgres",
  database: "mrbeeken_backend_test",
  hostname: "localhost",
  pool: Ecto.Adapters.SQL.Sandbox
