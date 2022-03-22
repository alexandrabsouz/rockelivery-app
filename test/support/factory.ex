defmodule Rockelivery.Factory do
  use ExMachina

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
end
