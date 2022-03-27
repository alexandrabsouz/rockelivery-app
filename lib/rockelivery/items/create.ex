defmodule Rockelivery.Items.Create do
  alias Rockelivery.{
    Error,
    Repo,
    Item
  }

  def call(params) do
    params
    |> Item.changeset()
    |> Repo.insert()
    |> handle_result()
  end

  defp handle_result({:ok, %Item{}} = result), do: result

  defp handle_result({:error, result}) do
    {:error, Error.build(:bad_request, result)}
  end
end

# {category: :food, description: "bananinha frita", price: Decimal.new("12.50"), photo: "/priv/banana_frita.jpg"}