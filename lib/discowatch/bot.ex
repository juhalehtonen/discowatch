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
      # Stats for someone else
      "!ow " <> name ->
        result = Discowatch.Scraper.scrape(name)

        case result do
          {wins, rank} ->
            :ignore
            #Api.create_message(msg.channel_id, "Player: #{name} / Total wins: #{wins} / Competitive rank: #{rank}")
          _ ->
            :ignore
        end
      # Personal stats
      "!mää" ->
        case discord_to_battlenet(msg.author.username) do
          {:ok, name}      ->
            result = Discowatch.Scraper.scrape(name)
            case result do
              {wins, rank} ->
                :ignore
                #Api.create_message(msg.channel_id, "Player: #{name} / Total wins: #{wins} / Competitive rank: #{rank}")
              _ ->
                :ignore
            end
          {:error, _reason} ->
            :ignore
            #Api.create_message(msg.channel_id, "Not on teh list jou matamou wou")
          _                ->
            :ignore
            #Api.create_message(msg.channel_id, "Jotain meni vikaan :))))))")
        end
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

  # Return Battle.net username from Discord username
  defp discord_to_battlenet(name) do
    case name do
      "milkflow"     -> {:ok, "milkflow-1434"}
      "skaabcurator" -> {:ok, "mahaa-2417"}
      "Ihmisraunio"  -> {:ok, "Ihmisraunio-2301"}
      "Karhuttaja"   -> {:ok, "Karhuttaja-2210"}
      "Cpt.Saatana"  -> {:ok, "CptSaatana-2396"}
      _              -> {:error, "Not on the list"}
    end
  end

end