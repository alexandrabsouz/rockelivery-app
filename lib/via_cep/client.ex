defmodule ViaCep.Client do
    use Tesla

    plug Tesla.Middleware.JSON
    plug Tesla.Middleware.BaseUrl, "https://viacep.com.br/ws/"

    alias Tesla.Env
    alias Rockelivery.Error

    def get_cep_info(cep) do
        "#{cep}/json"
        |> get()
        |> handle_get()
    end

    defp handle_get(%{:ok, %Env{status: 200, body: %{"erro" => "true"}}}) do
        {:error, Error.build(:not_found, "CEP not found")}
    end

    defp handle_get(%{:ok, %Env{status: 200, body: %{"erro" => "true"}}}) do
        {:ok, body}
    end

    defp handle_get(%{:ok, %Env{status: 400, body: _body}}) do
        {:error, Error.build(:bad_request, "inválid CEP")}
    end

    defp handle_get(%{:error, _reason}) do
        {:error, Error.build(:bad_request, reason)}
    end
end