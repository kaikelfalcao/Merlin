defmodule Merlin.Checker do
  def availbality(state) when is_struct(state) do
    passed_requests =
      state.servers
      |> Enum.filter(fn server ->
        case HTTPoison.get(server) do
          {:ok, response} -> response.status_code == 200
          _ -> false
        end
      end)

    failed_requests =
      state.servers |> Enum.reject(fn server -> passed_requests |> Enum.member?(server) end)

    state = %{state | ups: passed_requests, downs: failed_requests}

    state
  end

  def availbality do
    raise "Algo de Errado com o GenServer"
  end
end
