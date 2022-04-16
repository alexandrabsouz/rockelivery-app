defmodule Rockelivery.Users.GetTest do
  use Rockelivery.DataCase, async: True

  import Mox
  import Rockelivery.Factory

  alias Rockelivery.Users.{
    Create,
    Get
  }

  alias Rockelivery.Error
  alias Rockelivery.ViaCep.ClientMock

  describe "by_id/1" do
    test "when a valid uuid, returns an user" do
      user_params = build(:user_params)

      expect(ClientMock, :get_cep_info, fn _cep ->
        {:ok,
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
         }}
      end)

      assert {:ok, %{id: uuid}} = Create.call(user_params)
      assert {:ok, _result} = Get.by_id(uuid)
    end

    test "when not found user, return an error" do
      uuid = UUID.uuid4()
      assert {:error, %Error{result: "user not found.", status: :not_found}} = Get.by_id(uuid)
    end
  end
end
