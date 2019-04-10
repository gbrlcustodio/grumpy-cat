use Mix.Config

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :grumpy_cat, GrumpyCatWeb.Endpoint,
  http: [port: 4002],
  server: false

# Print only warnings and errors during test
config :logger, level: :warn

# Configure your database
config :grumpy_cat, GrumpyCat.Repo,
  username: "postgres",
  password: "postgres",
  database: "grumpy_cat_test",
  hostname: "localhost",
  pool: Ecto.Adapters.SQL.Sandbox

config :grumpy_cat, reverse_geocoding: GrumpyCatWeb.ReverseGeocoding.Mock
