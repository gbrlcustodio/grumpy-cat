defmodule GrumpyCat.Repo.Migrations.AddNotNullToComplaintCompany do
  use Ecto.Migration

  def up do
    execute """
      ALTER TABLE complaints ALTER COLUMN company_id SET NOT NULL;
    """
  end

  def down do
    execute """
      ALTER TABLE complaints ALTER COLUMN company_id DROP NOT NULL
    """
  end
end
