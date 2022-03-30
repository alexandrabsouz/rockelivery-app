defmodule Rockelivery.Orders.Create do
  alias Rockelivery.{
    User,
    Item,
    Order
  }

  alias Rockelivery.Repo

  import Ecto.Query

  def call(params) do
    params
    |> fetch_items()
  end

  defp fetch_items(%{"items" => items_params}) do
    items_ids = Enum.map(items_params, fn item -> item["id"] end)

    query = from item in Item, where: item.id in ^items_ids

    query
    |> Repo.all()
    |> validate_items(items_ids)
  end

  defp validate_items(items, items_ids) do
    item_map = Map.new(items, fn item -> {item.id, item} end)

    items_ids
    |> Enum.map(fn id -> {id, Map.get(item_map, id)} end)
    |> Enum.any?(fn {_id, value} -> is_nil(value) end)
  end
end