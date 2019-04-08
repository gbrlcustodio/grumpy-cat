defmodule GrumpyCatWeb.ComplaintControllerTest do
  use GrumpyCatWeb.ConnCase

  alias GrumpyCat.Complaints
  alias GrumpyCat.Complaints.Complaint

  @create_attrs %{
    description: "some description",
    locale: "some locale",
    title: "some title"
  }
  @update_attrs %{
    description: "some updated description",
    locale: "some updated locale",
    title: "some updated title"
  }
  @invalid_attrs %{description: nil, locale: nil, title: nil}

  def fixture(:complaint) do
    {:ok, complaint} = Complaints.create_complaint(@create_attrs)
    complaint
  end

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all complaints", %{conn: conn} do
      conn = get(conn, Routes.complaint_path(conn, :index))
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create complaint" do
    test "renders complaint when data is valid", %{conn: conn} do
      conn = post(conn, Routes.complaint_path(conn, :create), complaint: @create_attrs)
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get(conn, Routes.complaint_path(conn, :show, id))

      assert %{
               "id" => id,
               "description" => "some description",
               "locale" => "some locale",
               "title" => "some title"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.complaint_path(conn, :create), complaint: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update complaint" do
    setup [:create_complaint]

    test "renders complaint when data is valid", %{conn: conn, complaint: %Complaint{id: id} = complaint} do
      conn = put(conn, Routes.complaint_path(conn, :update, complaint), complaint: @update_attrs)
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get(conn, Routes.complaint_path(conn, :show, id))

      assert %{
               "id" => id,
               "description" => "some updated description",
               "locale" => "some updated locale",
               "title" => "some updated title"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn, complaint: complaint} do
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
end
