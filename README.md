# Discowatch
A simple Discord bot and web scraper (as Blizzard hasn't put out a proper API for
Overwatch yet). Fetches OW statistics for users and replies them back on demand.

## Usage
Currently only two commands are available:

- `!ow battletag-000` returns stats for the given battletag
- `!mää` returns stats for message sender, if whitelisted (aka. hardcoded)

## Configuration
Configure `dev.secret.exs` with Discord API token and the list of users you want
to store for the `!mää` command:

```elixir
use Mix.Config

# Configure Discord token
config :nostrum,
  token: "abc", # The token of your bot as a string
  num_shards: 1 # The number of shards you want to run your bot under, or :auto.

# Configure map of Discord username <-> Battletag combinations
config :discowatch, :d2b, %{
    "User 1" => "user1-1434",
    "User 2" => "user2-2396",
    "User 3" => "user3-2417"
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
2. Then compile and package the release: `docker run -v %CD%/releases:/app/releases build-elixir mix release --env=prod`
3. (Or use the above but with `mix release --upgrade --env=prod` to build an upgrade release)

Now you can deploy the resulting `releases/discowatch/releases/0.1.0/discowatch.tar.gz.`
release tarball to any Debian based Linux environment (like Ubuntu 16.04).

To run the release as a daemon: `bin/discowatch start`, and to stop: `bin/discowatch stop`.
If you want to, you can also connect a shell to the running release: `bin/discowatch remote_console`

The start command of the boot script will automatically handle running your
release as a daemon, but if you would rather use upstart or supervisord or
whatever, use the foreground task instead.