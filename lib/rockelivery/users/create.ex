defmodule Rockelivery.Users.Create do
  alias Rockelivery.{Repo, User}

  def call(params) do
    params
    |> User.changeset()
    |> Repo.insert()
    |> handle_result()
  end

  defp handle_result({:ok, %User{}} = result), do: result

  defp handle_result({:error, result}) do
    {:error, %{status: :bad_request, result: result}}
  end
end
