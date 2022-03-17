defmodule RockeliveryWeb.Plugs.UUIDChecker do
    import Plug.Conn

    alias Ecto.UUID
    alias Plug.Conn

    def init(opts), do: opts

    def call(%Conn{params: %{"id" => id}} = conn, opts) do
        case UUID.cast(id) do
            :error -> render_error(conn)
            {:ok, _uuid} -> conn
        end
    end

    def call(conn, _opts), do: conn

    defp render_error(conn) do
        body = Jason.encode!(%{message: "Invalid UUID"})

        conn
        |> put_resp_content_type("aplication/json")
        |> send_resp(:bad_request, body)
        |> halt()
    end
end