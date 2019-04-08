defmodule GrumpyCatWeb.ComplaintController do
  use GrumpyCatWeb, :controller

  alias GrumpyCat.Complaints
  alias GrumpyCat.Complaints.Complaint

  action_fallback GrumpyCatWeb.FallbackController

  def index(conn, _params) do
    complaints = Complaints.list_complaints()
    render(conn, "index.json", complaints: complaints)
  end

  def create(conn, %{"complaint" => complaint_params}) do
    with {:ok, %Complaint{} = complaint} <- Complaints.create_complaint(complaint_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", Routes.complaint_path(conn, :show, complaint))
      |> render("show.json", complaint: complaint)
    end
  end

  def show(conn, %{"id" => id}) do
    complaint = Complaints.get_complaint!(id)
    render(conn, "show.json", complaint: complaint)
  end

  def update(conn, %{"id" => id, "complaint" => complaint_params}) do
    complaint = Complaints.get_complaint!(id)

    with {:ok, %Complaint{} = complaint} <- Complaints.update_complaint(complaint, complaint_params) do
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
