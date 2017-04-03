[![Build Status](https://travis-ci.org/juhalehtonen/discowatch.svg?branch=master)](https://travis-ci.org/juhalehtonen/discowatch)

# Discowatch
A simple Discord bot and web scraper (as Blizzard hasn't put out a proper API for
Overwatch yet). Fetches OW statistics for users and replies them back on demand.

## Usage
Currently only two commands are available:

- `!ow battletag-000` returns stats for the given battletag
- `!mää` returns stats for message sender, if added to `config/usernames.exs`

## Configuration
Set the `DISCORD_API_TOKEN` environment variable to your Discord API token, and 
configure `usernames.exs` with list of users you want to store for the `!mää` command:

```elixir
use Mix.Config

# Configure map of Discord username <-> Battletag combinations
config :discowatch, :d2b, %{
    "User 1" => "usertag1-1434",
    "User 2" => "usertag2-2396",
    "User 3" => "usertag3-2417"
}
```

## Testing
Simply run `mix test` to run all the tests.

## Running and building
First of all, run `mix deps.get` to get the dependencies.

For development, you can simply run `iex -S mix` to run the bot and have it
automatically connect to your Discord server. For releases, Discowatch uses
`Distillery`. Check out the Distillery docs for details on how to build and
run releases.

### Docker

1. First build a Docker image: `docker build --tag=build-elixir -f Dockerfile .`
2. Then compile and package the release: `docker run -e MIX_ENV=prod -v %CD%/releases:/app/releases build-elixir mix release --env=prod`
3. (Or use the above but with `mix release --upgrade --env=prod` to build an upgrade release)

Now you can deploy the resulting `releases/discowatch/releases/0.1.0/discowatch.tar.gz.`
release tarball to any Debian based Linux environment (like Ubuntu 16.04).

To run the release as a daemon: `bin/discowatch start`, and to stop: `bin/discowatch stop`.
If you want to, you can also connect a shell to the running release: `bin/discowatch remote_console`

The start command of the boot script will automatically handle running your
release as a daemon, but if you would rather use upstart or supervisord or
whatever, use the foreground task instead.
