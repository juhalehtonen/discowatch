defmodule DiscowatchTest do
  use ExUnit.Case
  doctest Discowatch

  @tag :bot
  test "discord name to battletag conversion works when name is whitelisted" do
    assert {:ok, "milkflow-1434"} = Discowatch.Bot.discord_to_battletag("milkflow")
  end

  @tag :bot
  test "discord name to battletag conversion fails when name is not whitelisted" do
    assert {:error, _reason} = Discowatch.Bot.discord_to_battletag("makkaraperuna")
  end

  @tag :scraper
  test "scraping is successful when provided name exists" do
    assert {:ok, _wins, _rank} = Discowatch.Scraper.scrape("milkflow-1434")
  end

  @tag :scraper
  test "scraping is not successful when provided name does not exist" do
    assert {:error, "not found"} = Discowatch.Scraper.scrape("notreallyexisting-13213434")
  end
end
