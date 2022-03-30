defmodule Rockelivery.Orders.Create do
  alias Rockelivery.{
    Item,
    Order,
    Error
  }

  alias Rockelivery.Repo

  import Ecto.Query

  def call(params) do
    params
    |> fetch_items()
    |> handle_items(params)
  end

  defp handle_items({:ok, items}, params) do
    params
    |> Order.changeset(items)
    |> Repo.insert()
    |> handle_insert()
  end

  defp handle_insert({:ok, %Order{}} = order), do: order

  defp handle_insert({:error, result}), do: {:error, Error.build(:bad_request, result)}

  defp handle_items({:error, result}, _params), do: {:error, Error.build(:bad_request, result)}

  defp fetch_items(%{"items" => items_params}) do
    items_ids = Enum.map(items_params, fn item -> item["id"] end)

    query = from item in Item, where: item.id in ^items_ids

    query
    |> Repo.all()
    |> validate_and_multiply_items(items_ids, items_params)
  end

  defp validate_and_multiply_items(items, items_ids, items_params) do
    item_map = Map.new(items, fn item -> {item.id, item} end)

    items_ids
    |> Enum.map(fn id -> {id, Map.get(item_map, id)} end)
    |> Enum.any?(fn {_id, value} -> is_nil(value) end)
    |> multiply_items(item_map, items_params)
  end

  defp multiply_items(true, _item_map, _items_params), do: {:error, "inválid items!"}

  defp multiply_items(false, item_map, items_params) do
    items =
      Enum.reduce(items_params, [], fn %{"id" => id, "quantity" => quantity}, acc ->
        item = Map.get(item_map, id)
        acc ++ List.duplicate(item, quantity)
      end)

    {:ok, items}
  end
end
