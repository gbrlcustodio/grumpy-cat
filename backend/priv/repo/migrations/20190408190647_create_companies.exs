defmodule GrumpyCat.Repo.Migrations.CreateCompanies do
  use Ecto.Migration

  def change do
    create table(:companies) do
      add :name, :string
      add :bio, :text

      timestamps()
    end
  end
end
