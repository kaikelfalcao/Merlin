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

    schedule()
    {:ok, state}
  end

  @impl true
  def handle_call(:servers, _from, state) do
    {:reply, state, state}
  end

  @impl true
  def handle_info(:schedule_check, state) do
    new_state = Merlin.Checker.availbality(state)
    schedule()
    {:noreply, new_state}
  end

  def teste do
    GenServer.call(__MODULE__, :servers)
  end

  def schedule do
    IO.puts("Schedule work happening in seconds")
    Process.send_after(self(), :schedule_check, 10_000)
  end
end
