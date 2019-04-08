defmodule GrumpyCat.Companies.Company do
  use Ecto.Schema
  import Ecto.Changeset

  schema "companies" do
    field :bio, :string
    field :name, :string

    timestamps()
  end

  @doc false
  def changeset(company, attrs) do
    company
    |> cast(attrs, [:name, :bio])
    |> validate_required([:name, :bio])
  end
end
