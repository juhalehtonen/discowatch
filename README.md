# Discowatch

A simple Discord bot and web scraper (as Blizzard hasn't put out a proper API for
Overwatch yet). Fetches OW statistics for users and replies them back on demand.

## Usage

Currently only two commands are available:

- `!ow battletag-000` returns stats for the given battletag
- `!mää` returns stats for message sender, if whitelisted (aka. hardcoded)


## Configuration

Configure `dev.secret.exs`:

```elixir
use Mix.Config

config :nostrum,
  token: "abc", # The token of your bot as a string
  num_shards: 1 # The number of shards you want to run your bot under, or :auto.
```