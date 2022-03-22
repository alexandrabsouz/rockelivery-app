defmodule Rockelivery.Users.GetTest do
  use Rockelivery.DataCase, async: True

  import Rockelivery.Factory

  alias Rockelivery.Users.{
    Create,
    Get
  }

  alias Rockelivery.Error

  describe "by_id/1" do
    test "when a valid uuid, returns an user" do
      user_params = build(:user_params)
      assert {:ok, %{id: uuid}} = Create.call(user_params)
      assert {:ok, _result} = Get.by_id(uuid)
    end

    test "when not found user, return an error" do
      uuid = UUID.uuid4()
      assert {:error, %Error{result: "user not found.", status: :not_found}} = Get.by_id(uuid)
    end
  end
end
