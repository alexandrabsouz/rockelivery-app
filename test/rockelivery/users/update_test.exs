defmodule Rockelivery.Users.UpdateTest do
  use Rockelivery.DataCase, async: True

  import Rockelivery.Factory

  alias Rockelivery.{
    Error,
    User
  }

  alias Rockelivery.Users.Create

  describe "call/1" do
    test "when all params are valid, update user" do
      uuid = "a8a8ef77-7eb9-4944-b163-842137ca696c"
      insert(:user)

      update_params = %{
        "name" => "Luizinha Dois Dedos",
        "age" => 35,
        "id" => uuid,
        "password" => "12ghjl3"
      }

      assert {:ok, %User{name: "Luizinha Dois Dedos", age: 35}} =
               Rockelivery.update_user(update_params)
    end

    test "when user not found, returns an error" do
      uuid = "a8a8ef77-7eb9-4944-b163-842137ca6968"
      insert(:user)

      update_params = %{
        "name" => "Luizinha Dois Dedos",
        "age" => 35,
        "id" => uuid,
        "password" => "12ghjl3"
      }

      assert {:error, %Rockelivery.Error{result: "user not found.", status: :not_found}} =
               Rockelivery.update_user(update_params)
    end

    test "when params are invalids, returns an error" do
      uuid = "a8a8ef77-7eb9-4944-b163-842137ca696c"
      insert(:user)

      update_params = %{
        "name" => "Luizinha Dois Dedos",
        "age" => 15,
        "id" => uuid,
        "password" => "123"
      }

      assert {:error, result} = Rockelivery.update_user(update_params)

      assert errors_on(result) == %{
               age: ["must be greater than or equal to 18"],
               password: ["should be at least 6 character(s)"]
             }
    end
  end
end
