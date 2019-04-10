defmodule GrumpyCatWeb.CompanyView do
  use GrumpyCatWeb, :view
  alias GrumpyCatWeb.CompanyView

  def render("index.json", %{companies: companies}) do
    %{data: render_many(companies, CompanyView, "company.json")}
  end

  def render("show.json", %{company: company}) do
    %{data: render_one(company, CompanyView, "company.json")}
  end

  def render("company.json", %{company: company}) do
    %{id: company.id, name: company.name, bio: company.bio}
  end
end
