defmodule GrumpyCatWeb.ComplaintControllerTest do
  use GrumpyCatWeb.ConnCase

  alias GrumpyCat.Companies
  alias GrumpyCat.Complaints
  alias GrumpyCat.Complaints.Complaint

  import Mox

  # This next line checks if the mocks have been properly called at the end of each test
  setup :verify_on_exit!

  @create_attrs %{
    description: "some description",
    latitude: 40.7308619,
    longitude: -73.9871558,
    title: "some title"
  }
  @update_attrs %{
    description: "some updated description",
    latitude: -25.43698,
    longitude: -54.58248,
    title: "some updated title"
  }
  @invalid_attrs %{description: nil, latitude: nil, longitude: nil, title: nil}

  def fixture(:complaint) do
    with {:ok, company} <- create_company(),
         {:ok, complaint} <-
           Complaints.create_complaint(%{
             description: "some description",
             country: "Brazil",
             state: "Paraná",
             city: "Foz do Iguaçu",
             title: "some title",
             company_id: company.id
           }) do
      complaint
    end
  end

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    setup [:create_complaint]

    test "lists all complaints", %{conn: conn, complaint: complaint} do
      conn = get(conn, Routes.complaint_path(conn, :index))
      complaint = Complaints.load_complaint_assocs(complaint)

      assert json_response(conn, 200)["data"] == [
               %{
                 "id" => complaint.id,
                 "title" => complaint.title,
                 "description" => complaint.description,
                 "city" => complaint.city,
                 "state" => complaint.state,
                 "country" => complaint.country,
                 "company" => %{
                   "id" => complaint.company.id,
                   "name" => complaint.company.name,
                   "bio" => complaint.company.bio
                 }
               }
             ]
    end

    test "fiters complaints based on query params", %{conn: conn, complaint: complaint} do
      conn = get(conn, Routes.complaint_path(conn, :index), %{company_id: complaint.company_id})
      complaint = Complaints.load_complaint_assocs(complaint)

      assert json_response(conn, 200)["data"] == [
               %{
                 "id" => complaint.id,
                 "title" => complaint.title,
                 "description" => complaint.description,
                 "city" => complaint.city,
                 "state" => complaint.state,
                 "country" => complaint.country,
                 "company" => %{
                   "id" => complaint.company.id,
                   "name" => complaint.company.name,
                   "bio" => complaint.company.bio
                 }
               }
             ]
    end

    test "lists nothing when invalid filters is provided", %{conn: conn} do
      conn = get(conn, Routes.complaint_path(conn, :index), %{company_id: 1})
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create complaint" do
    test "renders complaint when data is valid", %{conn: conn} do
      GrumpyCatWeb.ReverseGeocoding.Mock
      |> expect(
        :convert,
        fn _, _ ->
          {:ok, %{"country" => "USA", "state" => "New York", "city" => "New York City"}}
        end
      )

      {:ok, %{id: company_id, name: company_name, bio: company_bio}} = create_company()

      complaint =
        %{company_id: company_id}
        |> Enum.into(@create_attrs)

      conn = post(conn, Routes.complaint_path(conn, :create), complaint: complaint)
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get(conn, Routes.complaint_path(conn, :show, id))

      assert %{
               "id" => id,
               "description" => "some description",
               "country" => "USA",
               "state" => "New York",
               "city" => "New York City",
               "title" => "some title",
               "company" => %{"id" => ^company_id, "name" => ^company_name, "bio" => ^company_bio}
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn} do
      GrumpyCatWeb.ReverseGeocoding.Mock
      |> expect(
        :convert,
        fn _, _ ->
          {:error, "no results found"}
        end
      )

      conn = post(conn, Routes.complaint_path(conn, :create), complaint: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update complaint" do
    setup [:create_complaint]

    test "renders complaint when data is valid", %{
      conn: conn,
      complaint: %Complaint{id: id} = complaint
    } do
      GrumpyCatWeb.ReverseGeocoding.Mock
      |> expect(
        :convert,
        fn _, _ ->
          {:ok, %{"country" => "Brazil", "state" => "Paraná", "city" => "Foz do Iguaçu"}}
        end
      )

      conn = put(conn, Routes.complaint_path(conn, :update, complaint), complaint: @update_attrs)
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get(conn, Routes.complaint_path(conn, :show, id))

      assert %{
               "id" => id,
               "description" => "some updated description",
               "country" => "Brazil",
               "state" => "Paraná",
               "city" => "Foz do Iguaçu",
               "title" => "some updated title"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn, complaint: complaint} do
      GrumpyCatWeb.ReverseGeocoding.Mock
      |> expect(
        :convert,
        fn _, _ ->
          {:error, "no results found"}
        end
      )

      conn = put(conn, Routes.complaint_path(conn, :update, complaint), complaint: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete complaint" do
    setup [:create_complaint]

    test "deletes chosen complaint", %{conn: conn, complaint: complaint} do
      conn = delete(conn, Routes.complaint_path(conn, :delete, complaint))
      assert response(conn, 204)

      assert_error_sent 404, fn ->
        get(conn, Routes.complaint_path(conn, :show, complaint))
      end
    end
  end

  defp create_complaint(_) do
    complaint = fixture(:complaint)
    {:ok, complaint: complaint}
  end

  defp create_company() do
    Companies.create_company(%{name: "some name", bio: "some bio"})
  end
end
