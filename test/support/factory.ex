defmodule Rockelivery.Factory do
  use ExMachina.Ecto, repo: Rockelivery.Repo

  alias Rockelivery.User

  def user_params_factory do
    %{
      "age" => 23,
      "address" => "Rua Lidio Pimenta de Figueiredo",
      "cep" => "39690000",
      "cpf" => "67454356789",
      "email" => "alexandra@email.com",
      "password" => "amarelo@45",
      "name" => "Alexandra Souza"
    }
  end

  def user_factory do
    %User{
      age: 23,
      address: "Rua Lidio Pimenta de Figueiredo",
      cep: "39690000",
      cpf: "67454356789",
      email: "alexandra@email.com",
      password: "amarelo@45",
      name: "Alexandra Souza",
      id: "a8a8ef77-7eb9-4944-b163-842137ca696c"
    }
  end

  def cep_info_factory do
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
    }
  end
end
