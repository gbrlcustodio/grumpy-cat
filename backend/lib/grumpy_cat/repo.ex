defmodule GrumpyCat.Repo do
  use Ecto.Repo,
    otp_app: :grumpy_cat,
    adapter: Ecto.Adapters.Postgres
end
