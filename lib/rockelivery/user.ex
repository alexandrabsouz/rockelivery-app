defmodule Rockelivery.User do
    use Ecto.Schema

    import Ecto.Changeset

    @primery_key {:id, :binary_id, autogenerate: true}

    @required_params [:age, :address, :cep, :cpf, :email, :password_hash, :name]

    schema "users" do
        field :age, :integer
        field :address, :string
        field :cep, :string
        field :cpf, :string
        field :email, :string
        field :password_hash, :string
        field :name, :string

        timestamps()
    end

    def changeset(params) do
        %__MODULE__{}
        |> cast(params, @required_params)
    end
end

# user_params = %{age: 23, address: "Rua do Sol nascente", cep: "4567675", email: "ale@email.com", password_hash: "teste", name: "alexandra xxx"}