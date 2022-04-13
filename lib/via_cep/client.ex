defmodule ViaCep.Client do
  use Tesla

  plug Tesla.Middleware.JSON
  plug Tesla.Middleware.BaseUrl, "https://viacep.com.br/ws/"

  alias Rockelivery.Error
  alias Tesla.Env

  def get_cep_info(cep) do
    "#{cep}/json"
    |> get()
    |> IO.inspect()
    |> handle_get()
  end

  defp handle_get({:ok, %Env{status: 200, body: %{"erro" => true}}}) do
    {:error, Error.build(:not_found, "CEP not found")}
  end

  defp handle_get({:ok, %Env{status: 200, body: body}}) do
    {:ok, body}
  end

  defp handle_get({:ok, %Env{status: 400, body: _body}}) do
    {:error, Error.build(:bad_request, "inválid CEP")}
  end

  defp handle_get({:error, reason}) do
    {:error, Error.build(:bad_request, reason)}
  end
end
