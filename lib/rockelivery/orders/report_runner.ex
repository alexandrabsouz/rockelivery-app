defmodule Rockelivery.Orders.ReportRunner do
    use GenServer

    require Logger

    alias Rockelivery.Orders.Report

    def start_link(_initial_stack) do
        GenServer.start_link(__MODULE__, %{})
    end

    @impl true
    def init(state) do
        schedule_report_generation()
        {:ok, state}
    end

    @impl true
    # Recebe qualquer tipo de menssagem
    def handle_info(:generate, state) do
        Logger.info("Genereating report...")
        schedule_report_generation()
        Report.create()
        {:noreply, state}
    end

    def schedule_report_generation do
        Process.send_after(self(), :generate, 1000 * 10)
    end
end