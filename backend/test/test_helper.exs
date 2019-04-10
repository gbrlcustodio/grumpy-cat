ExUnit.start()
Ecto.Adapters.SQL.Sandbox.mode(GrumpyCat.Repo, :manual)

Mox.defmock(GrumpyCatWeb.ReverseGeocoding.Mock, for: GrumpyCatWeb.ReverseGeocoding)
