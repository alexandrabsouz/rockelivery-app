# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     Rockelivery.Repo.insert!(%Rockelivery.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.

alias Rockelivery.{Item, Order, User, Repo}

user = %User{
    age: 23,
    address: "Rua Tocantins",
    cep: "68165000",
    cpf: "23456787998",
    password: "teste123456",
    name: "Alexandra Souza"
}

%User{id: id} = Repo.insert!(user)

item1 = %Item{
    category: :food,
    description: "Batatinha Rugles",
    price: Decimal.new("15.00"),
    photo: "priv/photos/batatinha.jpg"
}

item2 = %Item{
    category: :food,
    description: "Bolacha Recheada",
    price: Decimal.new("4.00"),
    photo: "priv/photos/bolacha.jpg"
}

Repo.insert!(item1)
Repo.insert!(item2)

order = %Order{
    user_id: id,
    items: [item1, item1, item2],
    address: "Rua tocantins",
    comments: "Bolachinha da Oreo e Batata sabor Cebola",
    payment_method: :money
}

Repo.insert!(order)
