defmodule Discowatch.Scraper do
  @moduledoc """
  Contains functions associated with the Scraping part of Discowatch:

  - Getting HTTP responses
  - Parsing HTML
  """

  @doc """
  Main point of contact.
  """
  def scrape(name) when is_binary(name) do
    name
    |> player_url()
    |> get_response()
    |> parse_data()
  end

  @doc """
  Get profile page URL per player name.

  Name must include the numeric code.
  """
  def player_url(name) do
    "https://playoverwatch.com/en-us/career/pc/#{name}"
  end

  @doc """
  Get specified URL
  """
  def get_response(url) when is_binary(url) do
    case HTTPoison.get(url) do
      {:ok, %HTTPoison.Response{status_code: 200, body: body}} ->
        {:ok, body}
      {:ok, %HTTPoison.Response{status_code: 404}} ->
        {:error, "not found"}
      {:error, %HTTPoison.Error{reason: reason}} ->
        {:error, reason}
    end
  end
  def get_response(_url) do
    {:error, "passed url not in binary format"}
  end

  @doc """
  Parse data from HTTP response based on the type of data.
  """
  def parse_data(response) do
    case response do
      {:ok, body} ->
        process_overwatch_html(body)
      {:error, "not found"} ->
        {:error, "not found"}
      _ ->
        {:error, "general error"}
    end
  end

  # Helper to process HTML of the playoverwatch website
  defp process_overwatch_html(body) do
    # Get competitive rank
    rank = body |> Floki.find("#overview-section .show-for-lg .competitive-rank .u-align-center") |> Floki.text
    # Get total competitive games
    games = body |> Floki.find("#competitive > section:nth-child(3) > div:nth-child(1) > div:nth-child(3) > div:nth-child(7) > div:nth-child(1) > table:nth-child(1) > tbody:nth-child(2) > tr:nth-child(1) > td:nth-child(2)") |> Floki.text
    # Get total competitive wins
    wins =  body |> Floki.find("#competitive > section:nth-child(3) > div:nth-child(1) > div:nth-child(3) > div:nth-child(6) > div:nth-child(1) > table:nth-child(1) > tbody:nth-child(2) > tr:nth-child(3) > td:nth-child(2)") |> Floki.text
    # Get total competitive time played
    time = body |> Floki.find("#competitive > section:nth-child(3) > div:nth-child(1) > div:nth-child(3) > div:nth-child(6) > div:nth-child(1) > table:nth-child(1) > tbody:nth-child(2) > tr:nth-child(1) > td:nth-child(2)") |> Floki.text
    # Get most played competitive hero
    hero = body |> Floki.find("#competitive > section:nth-child(2) > div:nth-child(1) > div:nth-child(3) > div:nth-child(1) > div:nth-child(2) > div:nth-child(2) > div:nth-child(1)") |> Floki.text

    # Return collection
    {:ok, rank, games, wins, time, hero}
  end
end
