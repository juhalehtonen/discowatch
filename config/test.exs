use Mix.Config

# Configure Discord API token
config :nostrum,
  token: System.get_env("DISCORD_API_TOKEN"),
  num_shards: 1 # The number of shards you want to run your bot under, or :auto.

# Configure map of Discord username <-> Battletag combinations for testing
config :discowatch, :d2b, %{
    "Basic Forest" => "Plut0us-2241"
}