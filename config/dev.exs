use Mix.Config

config :mrbeeken_backend, MrbeekenBackendWeb.Endpoint,
  http: [port: 4000],
  code_reloader: true,
  check_origin: false,
  watchers: [node: ["node_modules/brunch/bin/brunch", "watch", "--stdin",
                    cd: Path.expand("../assets", __DIR__)]]

config :mrbeeken_backend, MrbeekenBackendWeb.Endpoint,
  live_reload: [
    patterns: [
      ~r{priv/static/.*(js|css|png|jpeg|jpg|gif|svg)$},
      ~r{priv/gettext/.*(po)$},
      ~r{lib/mrbeeken_backend_web/views/.*(ex)$},
      ~r{lib/mrbeeken_backend_web/templates/.*(eex)$}
    ]
  ]

# Do not include metadata nor timestamps in development logs
config :logger, :console, format: "[$level] $message\n"

# Set a higher stacktrace during development. Avoid configuring such
# in production as building large stacktraces may be expensive.
config :phoenix, :stacktrace_depth, 20

# Configure your database
config :mrbeeken_backend, MrbeekenBackend.Repo,
  adapter: Ecto.Adapters.Postgres,
  username: "postgres",
  password: "postgres",
  database: "mrbeeken_backend_dev",
  hostname: "localhost",
  pool_size: 10
