defmodule Rockelivery.UserTest do
    use Rockelivery.DataCase, async: True

    import Rockelivery.Factory

    alias Ecto.Changeset
    alias Rockelivery.User

    describe "changeset/2" do
        test "when all params are valid, returns a valid changeset" do

            params = %{
                age: 23,
                address: "Rua Lidio Pimenta de Figueiredo",
                cep: "39690000",
                cpf: "67454356789",
                email: "alexandra@email.com",
                password: "amarelo@45",
                name: "Alexandra"
            }

            response = User.changeset(params)

            assert %Changeset{changes: %{name: "Alexandra"}, valid?: true} = response
        end

        test "when updating changeset, returns a valid changeset with given changes" do
            params = %{
                age: 23,
                address: "Rua Lidio Pimenta de Figueiredo",
                cep: "39690000",
                cpf: "67454356789",
                email: "alexandra@email.com",
                password: "amarelo@45",
                name: "Alexandra"
            }

            update_params = %{
                name: "Julio",
                age: 19
            }
        
            response = 
                params
                |> User.changeset()
                |> User.changeset(update_params)

            assert %Changeset{changes: %{name: "Julio"}, valid?: true} = response
        end

        test "there are some error, returns a invalid changeset" do
            params = %{
                age: 13,
                address: "Rua Lidio Pimenta de Figueiredo",
                cep: "39690000",
                cpf: "67454356789",
                email: "alexandra@email.com",
                password: "amarelo@45",
                name: "Alexandra"
            }

            response = User.changeset(params)

            expected_response = %{age: ["must be greater than or equal to 18"]}

            assert errors_on(response) == expected_response
        end
    end
end