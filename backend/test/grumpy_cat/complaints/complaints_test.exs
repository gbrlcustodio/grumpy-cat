defmodule GrumpyCat.ComplaintsTest do
  use GrumpyCat.DataCase

  alias GrumpyCat.Complaints
  alias GrumpyCat.Companies

  describe "complaints" do
    setup [:create_company]

    alias GrumpyCat.Complaints.Complaint

    @valid_attrs %{
      description: "some description",
      country: "Brazil",
      state: "Paraná",
      city: "Curitiba",
      title: "some title"
    }
    @update_attrs %{
      description: "some updated description",
      country: "Taiwan",
      state: "Taiwan Province",
      city: "Hsinchu",
      title: "some updated title"
    }
    @invalid_attrs %{
      description: nil,
      country: nil,
      state: nil,
      city: nil,
      title: nil,
      company_id: nil
    }

    def complaint_fixture(attrs \\ %{}) do
      {:ok, complaint} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Complaints.create_complaint()

      complaint
    end

    test "list_complaints/0 returns all complaints", %{company: company} do
      complaint = complaint_fixture(%{company_id: company.id})
      assert Complaints.list_complaints() == [complaint]
    end

    test "get_complaint!/1 returns the complaint with given id", %{company: company} do
      complaint = complaint_fixture(%{company_id: company.id})
      assert Complaints.get_complaint!(complaint.id) == complaint
    end

    test "create_complaint/1 with valid data creates a complaint", %{company: company} do
      assert {:ok, %Complaint{} = complaint} =
               @valid_attrs
               |> Enum.into(%{company_id: company.id})
               |> Complaints.create_complaint()

      assert complaint.description == "some description"
      assert complaint.country == "Brazil"
      assert complaint.state == "Paraná"
      assert complaint.city == "Curitiba"
      assert complaint.title == "some title"
      assert complaint.company_id == company.id
    end

    test "create_complaint/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Complaints.create_complaint(@invalid_attrs)
    end

    test "update_complaint/2 with valid data updates the complaint", %{company: company} do
      complaint = complaint_fixture(%{company_id: company.id})

      assert {:ok, %Complaint{} = complaint} =
               Complaints.update_complaint(complaint, @update_attrs)

      assert complaint.description == "some updated description"
      assert complaint.country == "Taiwan"
      assert complaint.state == "Taiwan Province"
      assert complaint.city == "Hsinchu"
      assert complaint.title == "some updated title"
    end

    test "update_complaint/2 with invalid data returns error changeset", %{company: company} do
      complaint = complaint_fixture(%{company_id: company.id})
      assert {:error, %Ecto.Changeset{}} = Complaints.update_complaint(complaint, @invalid_attrs)
      assert complaint == Complaints.get_complaint!(complaint.id)
    end

    test "delete_complaint/1 deletes the complaint", %{company: company} do
      complaint = complaint_fixture(%{company_id: company.id})
      assert {:ok, %Complaint{}} = Complaints.delete_complaint(complaint)
      assert_raise Ecto.NoResultsError, fn -> Complaints.get_complaint!(complaint.id) end
    end

    test "change_complaint/1 returns a complaint changeset", %{company: company} do
      complaint = complaint_fixture(%{company_id: company.id})
      assert %Ecto.Changeset{} = Complaints.change_complaint(complaint)
    end
  end

  defp create_company(_) do
    {:ok, company} = Companies.create_company(%{name: "some name", bio: "some bio"})

    {:ok, company: company}
  end
end
