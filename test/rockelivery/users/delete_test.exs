
defmodule Rockelivery.Users.DeleteTest do
    use RockeliveryWeb.ConnCase, async: True

    import Rockelivery.Factory
  
    alias Rockelivery.{
      Error,
      User
    }
    alias Rockelivery.Users.Delete


    describe "call/1" do
        test "when id is valid, delete the user" do
          uuid = "a8a8ef77-7eb9-4944-b163-842137ca696c"
    
          insert(:user)
    
          assert {:ok,
                  %User{
                    address: "Rua Lidio Pimenta de Figueiredo"
                  }} = Delete.call(uuid)
        end
    
        test "when user not found, returns an error" do
          id = "a8a8ef77-7eb9-4944-b163-842137ca6968"
          insert(:user)
    
          assert {:error, %Error{result: "user not found.", status: :not_found}} =
            Delete.call(id)
        end
      end
end