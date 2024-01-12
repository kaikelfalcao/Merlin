defmodule Merlin.Application do
  use Application

  @impl true
  def start(_start_type, _start_args) do
    port = Application.get_env(:merlin, :port, 8080)
    servers = Application.get_env(:merlin, :servers)

    children = [
      {Merlin.Servers, servers}
    ]

    HTTPoison.start()

    # :timer.apply_interval(:timer.seconds(15), Merlin.Checker, :schedule_check, ["Ola from Timer"])
    Supervisor.start_link(children, strategy: :one_for_one)
  end
end
