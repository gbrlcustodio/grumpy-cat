defmodule GrumpyCat.ComplaintsTest do
  use GrumpyCat.DataCase

  alias GrumpyCat.Complaints

  describe "complaints" do
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
    @invalid_attrs %{description: nil, country: nil, state: nil, city: nil, title: nil}

    def complaint_fixture(attrs \\ %{}) do
      {:ok, complaint} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Complaints.create_complaint()

      complaint
    end

    test "list_complaints/0 returns all complaints" do
      complaint = complaint_fixture()
      assert Complaints.list_complaints() == [complaint]
    end

    test "get_complaint!/1 returns the complaint with given id" do
      complaint = complaint_fixture()
      assert Complaints.get_complaint!(complaint.id) == complaint
    end

    test "create_complaint/1 with valid data creates a complaint" do
      assert {:ok, %Complaint{} = complaint} = Complaints.create_complaint(@valid_attrs)
      assert complaint.description == "some description"
      assert complaint.country == "Brazil"
      assert complaint.state == "Paraná"
      assert complaint.city == "Curitiba"
      assert complaint.title == "some title"
    end

    test "create_complaint/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Complaints.create_complaint(@invalid_attrs)
    end

    test "update_complaint/2 with valid data updates the complaint" do
      complaint = complaint_fixture()

      assert {:ok, %Complaint{} = complaint} =
               Complaints.update_complaint(complaint, @update_attrs)

      assert complaint.description == "some updated description"
      assert complaint.country == "Taiwan"
      assert complaint.state == "Taiwan Province"
      assert complaint.city == "Hsinchu"
      assert complaint.title == "some updated title"
    end

    test "update_complaint/2 with invalid data returns error changeset" do
      complaint = complaint_fixture()
      assert {:error, %Ecto.Changeset{}} = Complaints.update_complaint(complaint, @invalid_attrs)
      assert complaint == Complaints.get_complaint!(complaint.id)
    end

    test "delete_complaint/1 deletes the complaint" do
      complaint = complaint_fixture()
      assert {:ok, %Complaint{}} = Complaints.delete_complaint(complaint)
      assert_raise Ecto.NoResultsError, fn -> Complaints.get_complaint!(complaint.id) end
    end

    test "change_complaint/1 returns a complaint changeset" do
      complaint = complaint_fixture()
      assert %Ecto.Changeset{} = Complaints.change_complaint(complaint)
    end
  end
end
