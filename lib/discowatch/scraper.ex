defmodule Discowatch.Scraper do
  @moduledoc """
  Contains functions associated with the Scraping part of Discowatch:

  - Getting HTTP responses
  - Parsing HTML
  """

  @doc """
  Main point of contact.
  """
  def scrape(name \\ "milkflow-1434") when is_binary(name) do
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
        IO.inspect reason
    end
  end

  @doc """
  Parse data from HTTP response based on the type of data.
  """
  def parse_data(response) do
    case response do
      {:ok, body} ->
        body
        |> Floki.find(".masthead-detail span")
        |> Floki.text
      {:error, "not found"} ->
        "Not found"
      _ ->
        "Error :)"
    end
  end
end