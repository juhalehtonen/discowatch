# Discowatch

A simple Discord bot and web scraper (as Blizzard hasn't put out a proper API for
Overwatch yet). Fetches OW statistics for users and replies them back on demand.

## Usage

Currently only two commands are available:

- `!ow battletag-000` returns stats for the given battletag
- `!mää` returns stats for message sender, if whitelisted (aka. hardcoded)


## Configuration

Note that `floki` requires Rust to be installed if you want to use the (better)
Rust-based HTML parser. This is optional, and not required by default.

Additionally, configure `dev.secret.exs` to interact with the Discord API:

```elixir
use Mix.Config

config :nostrum,
  token: "abc", # The token of your bot as a string
  num_shards: 1 # The number of shards you want to run your bot under, or :auto.
```

## Running and building

First of all, run `mix deps.get` to get the dependencies.

For development, you can simply run `iex -S mix` to run the bot and have it
automatically connect to your Discord server. For releases, Discowatch uses
`Distillery`. Check out the Distillery docs for details on how to build and
run releases.