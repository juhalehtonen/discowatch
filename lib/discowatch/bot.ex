defmodule Discowatch.Bot do
  @moduledoc """
  Contains functions to interact with the Discord bot.
  """
  use Nostrum.Consumer
  alias Nostrum.Api

  def start_link do
    Consumer.start_link(__MODULE__)
  end

  def handle_event({:MESSAGE_CREATE, {msg}, _ws_state}, state) do
    case msg.content do
      "testi" ->
        Api.create_message(msg.channel_id, "hehe")
      "owtesti" ->
        result = Discowatch.Scraper.scrape()
        Api.create_message(msg.channel_id, result)
      _ ->
        :ignore
        IO.puts "ABUA WAT"
    end

    {:ok, state}
  end

  # Default event handler, if you don't include this, your consumer WILL crash if
  # you don't have a method definition for each event type.
  def handle_event(_, state) do
    {:ok, state}
  end
end