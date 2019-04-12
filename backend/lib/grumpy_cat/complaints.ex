defmodule GrumpyCat.Complaints do
  @moduledoc """
  The Complaints context.
  """

  import Ecto.Query, warn: false
  alias GrumpyCat.Repo

  alias GrumpyCat.Complaints.Complaint

  @doc """
  Returns the list of complaints.

  ## Examples

      iex> list_complaints()
      [%Complaint{}, ...]

  """
  def list_complaints do
    Repo.all(Complaint)
  end

  @doc """
  Gets a single complaint.

  Raises `Ecto.NoResultsError` if the Complaint does not exist.

  ## Examples

      iex> get_complaint!(123)
      %Complaint{}

      iex> get_complaint!(456)
      ** (Ecto.NoResultsError)

  """
  def get_complaint!(id), do: Repo.get!(Complaint, id)

  @doc """
  Creates a complaint.

  ## Examples

      iex> create_complaint(%{field: value})
      {:ok, %Complaint{}}

      iex> create_complaint(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_complaint(attrs \\ %{}) do
    %Complaint{}
    |> Complaint.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Given a complaint, load its associations

  ## Examples

      eix> load_complaint_assocs(%Complaint{})
      {:ok, %Complaint{company: %Company{}}}

  """
  def load_complaint_assocs(complaint, assocs \\ [:company]) do
    complaint
    |> Repo.preload(assocs)
  end

  @doc """
  Updates a complaint.

  ## Examples

      iex> update_complaint(complaint, %{field: new_value})
      {:ok, %Complaint{}}

      iex> update_complaint(complaint, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_complaint(%Complaint{} = complaint, attrs) do
    complaint
    |> Complaint.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a Complaint.

  ## Examples

      iex> delete_complaint(complaint)
      {:ok, %Complaint{}}

      iex> delete_complaint(complaint)
      {:error, %Ecto.Changeset{}}

  """
  def delete_complaint(%Complaint{} = complaint) do
    Repo.delete(complaint)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking complaint changes.

  ## Examples

      iex> change_complaint(complaint)
      %Ecto.Changeset{source: %Complaint{}}

  """
  def change_complaint(%Complaint{} = complaint) do
    Complaint.changeset(complaint, %{})
  end
end
