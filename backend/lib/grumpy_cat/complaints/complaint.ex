defmodule GrumpyCat.Complaints.Complaint do
  use Ecto.Schema
  import Ecto.Changeset

  alias GrumpyCat.Companies.Company

  schema "complaints" do
    field :description, :string
    field :country, :string
    field :state, :string
    field :city, :string
    field :title, :string
    belongs_to :company, Company

    timestamps()
  end

  @doc false
  def changeset(complaint, attrs) do
    complaint
    |> cast(attrs, [:title, :description, :country, :state, :city, :company_id])
    |> validate_required([:title, :description, :country, :state, :city, :company_id])
  end
end
