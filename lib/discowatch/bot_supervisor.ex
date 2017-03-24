defmodule Discowatch.BotSupervisor do
  def start do
    import Supervisor.Spec

    # List comprehension creates a consumer per cpu core
    children = for i <- 1..System.schedulers_online, do: worker(Discowatch.Bot, [], id: i)

    Supervisor.start_link(children, strategy: :one_for_one)
  end
end