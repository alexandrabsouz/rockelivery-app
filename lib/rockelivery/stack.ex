defmodule Rockelivery.Stack do
    use GenServer


    #SERVER (CALLBACK)
    
    @impl true
    def init(stack) do
        {:ok, stack}
    end

    @impl true
    #SYNC
    def handle_call({:push, element}, _from, stack) do
        new_stack = [element | stack]
        {:reply, new_stack, new_stack}
    end

    @impl true
    #SYNC
    def handle_call(:pop, _from, [head | tail]) do
        {:reply, head, tail}
    end

    @impl true
    #SYNC
    def handle_call(:pop, _from, []) do
        {:reply, nil, []}
    end

    @impl true
    #ASYNC
    def handle_cast({:push, element}, stack) do
        {:noreply, [element | stack]}
    end
end