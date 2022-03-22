defmodule Rockelivery.Users.CreateTest do
  use Rockelivery.DataCase, async: True
  import Rockelivery.Factory

  alias Rockelivery.Error
  alias Rockelivery.Users.Create

  describe "call/1" do
    test "when all params are valid, returns an user" do
      params = build(:user_params)
      assert {:ok, _result} = Create.call(params)
    end

    test "when params are a invalid changeseat, returns an error" do
      params = build(:user_params, %{"age" => 15})
      assert {:error, %Error{status: :bad_request, result: result}} = Create.call(params)
      assert errors_on(result) == %{age: ["must be greater than or equal to 18"]}
    end
  end
end
