defmodule Discowatch.Bot do
  @moduledoc """
  Contains functions to interact with the Discord bot.

  Most importantly, `handle_event({:MESSAGE_CREATE, {msg}, _ws_state}, state)`
  is responsible for capturing messages sent on Discord and processing them.
  """

  use Nostrum.Consumer
  alias Nostrum.Api

  def start_link do
    Consumer.start_link(__MODULE__)
  end

  def handle_event({:MESSAGE_CREATE, {msg}, _ws_state}, state) do
    case msg.content do
      # Stats for someone else
      "!ow " <> name ->
        output_result(msg, name)
      # Personal stats
      "!mää" ->
        case discord_to_battletag(msg.author.username) do
          {:ok, name}      ->
            output_result(msg, name)
          {:error, reason} ->
            Api.create_message(msg.channel_id, "Error: #{reason}")
          _                ->
            Api.create_message(msg.channel_id, "Error: something went terribly wrong")
        end
      # Anything else is ignored
      _ ->
        :ignore
    end
    {:ok, state}
  end

  # Default event handler, if you don't include this, your consumer WILL crash if
  # you don't have a method definition for each event type.
  def handle_event(_, state) do
    {:ok, state}
  end

  @doc """
  Output the result to Discord.

  Takes the `msg` and the `name` to process and format results.
  """
  def output_result(msg, name) do
    result = Discowatch.Scraper.scrape(name)
    case result do
      {:ok, rank, games, wins, time, hero} ->
        Api.create_message(
          msg.channel_id,
          """
          Player: #{name}
          Rank: #{rank}
          Games: #{games}
          Wins: #{wins}
          Time played: #{time}
          Most played hero: #{hero}
          """
        )
      {:error, reason} ->
        Api.create_message(msg.channel_id, "Error: #{reason}")
      _ ->
        :ignore
    end
  end

  @doc """
  Return Battle.net username for given Discord username, or error if not set.
  """
  def discord_to_battletag(name) do
    # Map of Discord username <-> Battletag combinations
    if Map.has_key?(Application.get_env(:discowatch, :d2b), name) do
      {:ok, Map.get(Application.get_env(:discowatch, :d2b), name)}
    else
      {:error, "Not on the list"}
    end
  end
end