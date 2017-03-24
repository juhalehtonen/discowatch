defmodule Discowatch do
  @moduledoc """
  Documentation for Discowatch.
  """
  use Application

  def start(_type, _args) do
    Discowatch.BotSupervisor.start_link()
  end
end
