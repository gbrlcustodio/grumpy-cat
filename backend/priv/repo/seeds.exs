# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     GrumpyCat.Repo.insert!(%GrumpyCat.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.
alias GrumpyCat.Complaints
alias GrumpyCat.Companies

{:ok, %{id: some_company_id}} = Companies.create_company(%{name: "Some Company", bio: "Some bio"})

{:ok, %{id: another_company_id}} =
  Companies.create_company(%{name: "Another Company", bio: "Another bio"})

Complaints.create_complaint(%{
  title: "Some complaint",
  description: "Some description",
  company_id: some_company_id
})

Complaints.create_complaint(%{
  title: "Another complaint",
  description: "Another description",
  company_id: another_company_id
})
