defmodule RockeliveryTest do
  use Rockelivery.DataCase, async: True

  import Mox
  import Rockelivery.Factory

  alias Rockelivery.{
    Error,
    User
  }

  alias Rockelivery.ViaCep.ClientMock

  describe "create_user/1" do
    test "when all params are valid, returns an user" do
      user = build(:user_params)

      expect(ClientMock, :get_cep_info, fn _cep ->  {:ok,
      %{
        "bairro" => "Sé",
        "cep" => "01001-000",
        "complemento" => "lado ímpar",
        "ddd" => "11",
        "gia" => "1004",
        "ibge" => "3550308",
        "localidade" => "São Paulo",
        "logradouro" => "Praça da Sé",
        "siafi" => "7107",
        "uf" => "SP"
      }} end)

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

      assert {:error, %Error{result: "user not found.", status: :not_found}} =
               Rockelivery.delete_user(id)
    end
  end

  describe "get_user_by_id/1" do
    test "when exists, returns an user" do
      uuid = "a8a8ef77-7eb9-4944-b163-842137ca696c"
      insert(:user)

      assert {:ok, %User{name: "Alexandra Souza"}} = Rockelivery.get_user_by_id(uuid)
    end

    test "when not found user, returns an error" do
      uuid = "a8a8ef77-7eb9-4944-b163-842137ca6960"
      insert(:user)

      assert {:error, %Error{result: "user not found.", status: :not_found}} =
               Rockelivery.get_user_by_id(uuid)
    end
  end

  describe "update_user/1" do
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
