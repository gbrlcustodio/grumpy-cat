defmodule GrumpyCatWeb.ComplaintView do
  use GrumpyCatWeb, :view
  alias GrumpyCatWeb.ComplaintView

  def render("index.json", %{complaints: complaints}) do
    %{data: render_many(complaints, ComplaintView, "complaint.json")}
  end

  def render("show.json", %{complaint: complaint}) do
    %{data: render_one(complaint, ComplaintView, "complaint.json")}
  end

  def render("complaint.json", %{complaint: complaint}) do
    %{id: complaint.id,
      title: complaint.title,
      description: complaint.description,
      locale: complaint.locale}
  end
end
