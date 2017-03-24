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

## Testing
Simply run `mix test` to run all the tests.

## Running and building
First of all, run `mix deps.get` to get the dependencies.

For development, you can simply run `iex -S mix` to run the bot and have it
automatically connect to your Discord server. For releases, Discowatch uses
`Distillery`. Check out the Distillery docs for details on how to build and
run releases.

### Docker

- First build a Docker image: 
`docker build --tag=build-elixir -f Dockerfile .`

- Then compile and package the release: 
`docker run -v %CD%/releases:/app/releases build-elixir mix release --env=prod`

Now you can deploy the resulting `releases/discowatch/releases/0.1.0/discowatch.tar.gz.`
release tarball to any Debian based Linux environment (like Ubuntu 16.04). 

To run the release as a daemon: `bin/discowatch start`

To stop the release as a daemon: `bin/discowatch stop`

Connect a shell to the running release: `bin/discowatch remote_console`

The start command of the boot script will automatically handle running your 
release as a daemon, but if you would rather use upstart or supervisord or 
whatever, use the foreground task instead.