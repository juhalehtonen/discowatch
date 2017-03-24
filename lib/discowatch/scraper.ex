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
    wins = body |> Floki.find(".masthead-detail span") |> Floki.text
    # Get rank
    rank = body |> Floki.find("#overview-section .show-for-lg .competitive-rank .u-align-center") |> Floki.text

    # Return collection
    {:ok, wins, rank}
  end
end