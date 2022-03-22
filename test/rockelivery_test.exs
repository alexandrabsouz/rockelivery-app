defmodule RockeliveryTest do
  use RockeliveryWeb.ConnCase, async: True

  import Rockelivery.Factory

  alias Rockelivery.{
    Error,
    User
  }

  describe "create_user/1" do
    test "when all params are valid, returns an user" do
      user = build(:user_params)
      assert {:ok, %User{name: "Alexandra Souza"}} = Rockelivery.create_user(user)
    end

    test "when there is some error, returns the error" do
      user = build(:user_params, %{"age" => 15})

      assert {:error, %Error{status: :bad_request, result: _result}} =
               Rockelivery.create_user(user)
    end
  end

  describe "delete_user/1" do
    test "when id is valid, delete the user" do
      uuid = "a8a8ef77-7eb9-4944-b163-842137ca696c"

      insert(:user)

      assert {:ok,
              %User{
                address: "Rua Lidio Pimenta de Figueiredo"
              }} = Rockelivery.delete_user(uuid)
    end

    test "when user not found, returns an error" do
        id = "a8a8ef77-7eb9-4944-b163-842137ca6968"
        insert(:user)

        assert {:error, %Error{result: "user not found.", status: :not_found}} = Rockelivery.delete_user(id)
    end
  end
end
