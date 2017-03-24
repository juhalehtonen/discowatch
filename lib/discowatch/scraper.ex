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
    "https://playoverwatch.com/en-us/career/pc/eu/#{name}"
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
    # Get total wins
    # wins = body |> Floki.find(".masthead-detail span") |> Floki.text
    # Get competitive rank
    comp_rank = body |> Floki.find("#overview-section .show-for-lg .competitive-rank .u-align-center") |> Floki.text
    # Get total competitive games
    comp_games = body |> Floki.find("#competitive > section:nth-child(3) > div:nth-child(1) > div:nth-child(3) > div:nth-child(7) > div:nth-child(1) > table:nth-child(1) > tbody:nth-child(2) > tr:nth-child(1) > td:nth-child(2)") |> Floki.text
    # Get total competitive wins
    comp_wins =  body |> Floki.find("#competitive > section:nth-child(3) > div:nth-child(1) > div:nth-child(3) > div:nth-child(7) > div:nth-child(1) > table:nth-child(1) > tbody:nth-child(2) > tr:nth-child(2) > td:nth-child(2)") |> Floki.text
    # Get total competitive time played
    comp_time_played = body |> Floki.find("#competitive > section:nth-child(3) > div:nth-child(1) > div:nth-child(3) > div:nth-child(7) > div:nth-child(1) > table:nth-child(1) > tbody:nth-child(2) > tr:nth-child(5) > td:nth-child(2)") |> Floki.text

    # Return collection
    {:ok, comp_rank, comp_games, comp_wins, comp_time_played}
  end
end