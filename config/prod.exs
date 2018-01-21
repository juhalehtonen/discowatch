use Mix.Config

# Configure Discord API token
config :nostrum,
  token: "${DISCORD_API_TOKEN}",
  num_shards: 1 # The number of shards you want to run your bot under, or :auto.

# Import map of Discord <> Battletag username combinations
import_config "usernames.exs"
