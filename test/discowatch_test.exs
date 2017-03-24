defmodule DiscowatchTest do
  @moduledoc """
  Insert all Discowatch tests on this file, unless we start expanding features
  and want to split the scraper and the bot to separate files.

  Prefer placing the expected result on the right, unless the assertion is a
  pattern match. Whatever you do, be consistent about it.
  """

  use ExUnit.Case
  alias Discowatch.Scraper
  alias Discowatch.Bot
  doctest Discowatch

  ## BOT
  @tag :bot
  test "discord name to battletag conversion works when name is whitelisted" do
    assert {:ok, "milkflow-1434"} = Bot.discord_to_battletag("milkflow")
  end

  @tag :bot
  test "discord name to battletag conversion fails when name is not whitelisted" do
    assert {:error, _reason} = Bot.discord_to_battletag("makkaraperuna")
  end

  @tag :bot
  test "event handler does not jam when faced with unknown event" do
    assert {:ok, _state} = Bot.handle_event({:GATOS_PERROS}, %{})
  end

  ## SCRAPER
  @tag :scraper
  test "correct url is rturned depending on the name passed to it" do
    assert "https://playoverwatch.com/en-us/career/pc/eu/abc" = Scraper.player_url("abc")
  end

  @tag :scraper
  test "scraping is successful when provided name exists" do
    assert {:ok, _wins, _rank} = Scraper.scrape("milkflow-1434")
  end

  @tag :scraper
  test "scraping is not successful when provided name does not exist" do
    assert {:error, "not found"} = Scraper.scrape("notreallyexisting-13213434")
  end

  @tag :scraper
  test "getting a response not attempted when passed url is not in binary format" do
    {:error, "passed url not in binary format"} = Scraper.get_response(1)
  end
end
