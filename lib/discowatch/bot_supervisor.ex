defmodule Discowatch.BotSupervisor do
  use Supervisor

  def start_link do
    Supervisor.start_link(__MODULE__, :ok)
  end

  def init(:ok) do
    children = for i <- 1..System.schedulers_online, do: worker(Discowatch.Bot, [], id: i)
    supervise(children, strategy: :one_for_one)
  end

end