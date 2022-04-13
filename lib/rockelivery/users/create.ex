defmodule Rockelivery.Users.Create do
  alias Rockelivery.{
    Error,
    Repo,
    User
  }

  alias ViaCep.Client

  def call(%{"cep" => cep} = params) do
    with {:ok, %User{} = user} <- User.build(params),
         {:ok, _cep_info} <- Client.get_cep_info(cep) do
        Repo.insert(user)
         else
          {:error, %Error{}} = error -> error
          {:error, result} -> {:error, Error.build(:bad_request, result)}
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
