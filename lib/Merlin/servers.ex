defmodule Merlin.ServerStruct do
  defstruct ups: [], downs: [], servers: []
end

defmodule Merlin.Servers do
  use GenServer

  def start_link(servers) do
    GenServer.start_link(__MODULE__, servers, name: __MODULE__)
  end

  @impl true
  def init(servers) do
    state =
      %Merlin.ServerStruct{ups: [], downs: [], servers: servers} |> Merlin.Checker.availbality()

    {:ok, state}
  end

  @impl true
  def handle_call(:servers, _from, state) do
    {:reply, state, state}
  end

  @impl true
  def handle_cast({:push, element}, state) do
    new_state = [element | state]
    {:noreply, new_state}
  end

  def teste do
    GenServer.call(__MODULE__, :servers)
  end
end
