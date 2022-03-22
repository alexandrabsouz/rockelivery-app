defmodule RockeliveryWeb.UsersViewTest do
    use RockeliveryWeb.ConnCase, async: true

    import Rockelivery.Factory
    import Phoenix.View

    alias RockeliveryWeb.UsersView

    test "renders create.json" do
        user = build(:user)
        response = render(UsersView, "create.json", user: user)
        assert %{message: "User cerated!",
                user: %Rockelivery.User{
                    address: "Rua Lidio Pimenta de Figueiredo",
                    age: 23,
                    cep: "39690000",
                    cpf: "67454356789",
                    email: "alexandra@email.com",
                    id: "a8a8ef77-7eb9-4944-b163-842137ca696c",
                    inserted_at: nil,
                    name: "Alexandra Souza",
                    password: "amarelo@45",
                    password_hash: nil,
                    updated_at: nil
                }
            } == response
    end
end