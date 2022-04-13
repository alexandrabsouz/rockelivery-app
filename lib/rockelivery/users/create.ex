defmodule Rockelivery.Users.Create do
  alias Rockelivery.{
    Error,
    Repo,
    User
  }

  alias ViaCep.Client

  def call(%{"cep" => cep} = params) do
    case Client.get_cep_info(cep) do
      {:ok, _cep_info} -> create_user(params)
      {:error, _error} = error -> error
    end 
  end

  defp create_user(params) do
    params
    |> User.changeset()
    |> Repo.insert()
    |> handle_result()
  end

  defp handle_result({:ok, %User{}} = result), do: result

  defp handle_result({:error, result}) do
    {:error, Error.build(:bad_request, result)}
  end
end
