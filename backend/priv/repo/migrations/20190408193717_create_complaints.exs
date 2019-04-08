defmodule GrumpyCat.Repo.Migrations.CreateComplaints do
  use Ecto.Migration

  def change do
    create table(:complaints) do
      add :title, :string
      add :description, :text
      add :locale, :string
      add :company_id, references(:companies, on_delete: :nothing)

      timestamps()
    end

    create index(:complaints, [:company_id])
  end
end
