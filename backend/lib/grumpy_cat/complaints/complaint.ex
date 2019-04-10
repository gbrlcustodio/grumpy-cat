defmodule GrumpyCat.Complaints.Complaint do
  use Ecto.Schema
  import Ecto.Changeset

  schema "complaints" do
    field :description, :string
    field :country, :string
    field :state, :string
    field :city, :string
    field :title, :string
    field :company_id, :id

    timestamps()
  end

  @doc false
  def changeset(complaint, attrs) do
    complaint
    |> cast(attrs, [:title, :description, :country, :state, :city])
    |> validate_required([:title, :description, :country, :state, :city])
  end
end
