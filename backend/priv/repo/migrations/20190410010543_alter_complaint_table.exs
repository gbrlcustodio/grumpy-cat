defmodule GrumpyCat.Repo.Migrations.AlterComplaintTable do
  use Ecto.Migration

  def change do
    alter table("complaints") do
      remove :locale
      add :country, :string
      add :state, :string
      add :city, :string
    end
  end
end
