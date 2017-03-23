# Discowatch

Configure dev.secret.exs:

```elixir
config :nostrum,
  token: "abc", # The token of your bot as a string
  num_shards: 1 # The number of shards you want to run your bot under, or :auto.
```

## Installation

If [available in Hex](https://hex.pm/docs/publish), the package can be installed
by adding `discowatch` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [{:discowatch, "~> 0.1.0"}]
end
```

Documentation can be generated with [ExDoc](https://github.com/elixir-lang/ex_doc)
and published on [HexDocs](https://hexdocs.pm). Once published, the docs can
be found at [https://hexdocs.pm/discowatch](https://hexdocs.pm/discowatch).

