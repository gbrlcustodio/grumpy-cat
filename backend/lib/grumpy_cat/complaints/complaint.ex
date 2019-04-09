defmodule GrumpyCat.Complaints.Complaint do
  use Ecto.Schema
  import Ecto.Changeset

  schema "complaints" do
    field :description, :string
    field :locale, :string
    field :title, :string
    field :company_id, :id

    timestamps()
  end

  @doc false
  def changeset(complaint, attrs) do
    complaint
    |> cast(attrs, [:title, :description, :locale])
    |> validate_required([:title, :description, :locale])
  end
end
