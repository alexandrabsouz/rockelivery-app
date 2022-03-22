defmodule Rockelivery.UserTest do
  use Rockelivery.DataCase, async: True

  import Rockelivery.Factory

  alias Ecto.Changeset
  alias Rockelivery.User

  describe "changeset/2" do
    test "when all params are valid, returns a valid changeset" do
      params = build(:user_params)

      response = User.changeset(params)

      assert %Changeset{changes: %{name: "Alexandra Souza"}, valid?: true} = response
    end

    test "when updating changeset, returns a valid changeset with given changes" do
      params = build(:user_params)

      update_params = %{
        name: "Julio",
        age: 19
      }

      response =
        params
        |> User.changeset()
        |> User.changeset(update_params)

      assert %Changeset{changes: %{name: "Julio"}, valid?: true} = response
    end

    test "there are some error, returns a invalid changeset" do
      params = build(:user_params, %{age: 15, password: "123"})

      response = User.changeset(params)

      expected_response = %{age: ["must be greater than or equal to 18"], password: ["should be at least 6 character(s)"]}

      assert errors_on(response) == expected_response
    end
  end
end