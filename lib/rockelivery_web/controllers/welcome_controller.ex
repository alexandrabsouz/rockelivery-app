defmodule RockeliveryWeb.WelcomeController do
    use RockeliveryWeb, :controller
    

    def index(conn, params) do
        conn
        |> put_status(:ok)
        |> text("Hello world :D")
    end
end