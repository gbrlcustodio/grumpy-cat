defmodule GrumpyCatWeb.ComplaintController do
  use GrumpyCatWeb, :controller

  alias GrumpyCat.Complaints
  alias GrumpyCat.Complaints.Complaint

  action_fallback GrumpyCatWeb.FallbackController

  @reverse_geocoding Application.get_env(:grumpy_cat, :reverse_geocoding)

  def index(conn, params) do
    complaints =
      Complaints.list_complaints(params)
      |> Complaints.load_complaint_assocs()

    render(conn, "index.json", complaints: complaints)
  end

  def create(conn, %{
        "complaint" => %{"latitude" => latitude, "longitude" => longitude} = complaint_params
      }) do
    with {:ok, location} <- @reverse_geocoding.convert(latitude, longitude),
         {:ok, %Complaint{} = complaint} <-
           Complaints.create_complaint(Map.merge(complaint_params, location)) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", Routes.complaint_path(conn, :show, complaint))
      |> render("show.json", complaint: complaint)
    else
      {:error, _reason} -> {:error, :unprocessable_entity}
    end
  end

  def show(conn, %{"id" => id}) do
    complaint =
      Complaints.get_complaint!(id)
      |> Complaints.load_complaint_assocs()

    render(conn, "show.json", complaint: complaint)
  end

  def update(
        conn,
        %{
          "complaint" =>
            %{
              "latitude" => latitude,
              "longitude" => longitude
            } = complaint
        } = params
      ) do
    case @reverse_geocoding.convert(latitude, longitude) do
      {:ok, location} ->
        complaint =
          Map.merge(complaint, location)
          |> Map.delete("latitude")
          |> Map.delete("longitude")

        update(conn, Map.merge(params, %{"complaint" => complaint}))

      {:error, _reason} ->
        {:error, :unprocessable_entity}
    end
  end

  def update(conn, %{"id" => id, "complaint" => complaint_params}) do
    complaint = Complaints.get_complaint!(id)

    with {:ok, %Complaint{} = complaint} <-
           Complaints.update_complaint(complaint, complaint_params) do
      render(conn, "show.json", complaint: complaint)
    end
  end

  def delete(conn, %{"id" => id}) do
    complaint = Complaints.get_complaint!(id)

    with {:ok, %Complaint{}} <- Complaints.delete_complaint(complaint) do
      send_resp(conn, :no_content, "")
    end
  end
end
