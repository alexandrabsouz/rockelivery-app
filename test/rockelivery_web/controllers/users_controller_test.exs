defmodule RockeliveryWeb.UsersControllerTest do
  use RockeliveryWeb.ConnCase, async: True

  import Rockelivery.Factory

  describe "create/2" do
    test "when all params are valid, creates the user", %{conn: conn} do
      params = build(:user_params)

      response =
        conn
        |> post(Routes.users_path(conn, :create, params))
        |> json_response(:created)

      assert %{
               "message" => "User cerated!",
               "user" => %{
                 "address" => "Rua Lidio Pimenta de Figueiredo",
                 "age" => 23,
                 "cpf" => "67454356789",
                 "email" => "alexandra@email.com",
                 "id" => _id
               }
             } = response
    end

    test "when there is some error, returns the error", %{conn: conn} do
      params = %{
        "password" => "555555555",
        "name" => "Alexandra",
        "cep" => "39690000"
      }

      response =
        conn
        |> post(Routes.users_path(conn, :create, params))
        |> json_response(:bad_request)

      expected_response = %{
        "message" => %{
          "address" => ["can't be blank"],
          "age" => ["can't be blank"],
          "cpf" => ["can't be blank"],
          "email" => ["can't be blank"]
        }
      }

      assert expected_response == response
    end
  end

  describe "delete/2" do
    test "when there is a user with the given id, deletes the user", %{conn: conn} do
      uuid = "a8a8ef77-7eb9-4944-b163-842137ca696c"
      insert(:user)

      response =
        conn
        |> delete(Routes.users_path(conn, :delete, uuid))
        |> response(:no_content)

      assert response == ""
    end
  end
end
