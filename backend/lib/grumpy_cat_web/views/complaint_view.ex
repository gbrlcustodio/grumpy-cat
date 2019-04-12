defmodule GrumpyCatWeb.ComplaintView do
  use GrumpyCatWeb, :view
  alias GrumpyCatWeb.ComplaintView
  alias GrumpyCat.Complaints.Complaint

  def render("index.json", %{complaints: complaints}) do
    %{data: render_many(complaints, ComplaintView, "complaint.json")}
  end

  def render("show.json", %{complaint: complaint}) do
    %{data: render_one(complaint, ComplaintView, "complaint.json")}
  end

  def render("complaint.json", %{complaint: complaint}) do
    raw = %{
      id: complaint.id,
      title: complaint.title,
      description: complaint.description,
      country: complaint.country,
      state: complaint.state,
      city: complaint.city
    }

    render_company(raw, complaint)
  end

  defp render_company(json, %Complaint{company: company}) do
    if Ecto.assoc_loaded?(company) do
      Enum.into(json, %{
        company: %{
          id: company.id,
          name: company.name,
          bio: company.bio
        }
      })
    else
      json
    end
  end
end
