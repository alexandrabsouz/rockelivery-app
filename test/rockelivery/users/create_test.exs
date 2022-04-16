defmodule Rockelivery.Users.CreateTest do
  use Rockelivery.DataCase, async: True
  import Rockelivery.Factory
  import Mox
  alias Rockelivery.Error
  alias Rockelivery.Users.Create
  alias Rockelivery.ViaCep.ClientMock

  describe "call/1" do
    test "when all params are valid, returns an user" do
      params = build(:user_params)

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

      assert {:ok, _result} = Create.call(params)
    end

    test "when params are a invalid changeseat, returns an error" do
      params = build(:user_params, %{"age" => 15})
      assert {:error, %Error{status: :bad_request, result: result}} = Create.call(params)
      assert errors_on(result) == %{age: ["must be greater than or equal to 18"]}
    end
  end
end
