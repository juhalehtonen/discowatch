defmodule Discowatch.Mixfile do
  use Mix.Project

  def project do
    [app: :discowatch,
     version: "0.1.11",
     elixir: "~> 1.4",
     build_embedded: Mix.env == :prod,
     start_permanent: Mix.env == :prod,
     deps: deps()]
  end

  # Configuration for the OTP application
  #
  # Type "mix help compile.app" for more information
  def application do
    # Specify extra applications you'll use from Erlang/Elixir
    [extra_applications: [:logger],
    mod: {Discowatch, []}]
  end

  # Dependencies can be Hex packages:
  #
  #   {:my_dep, "~> 0.3.0"}
  #
  # Or git/path repositories:
  #
  #   {:my_dep, git: "https://github.com/elixir-lang/my_dep.git", tag: "0.1.0"}
  #
  # Type "mix help deps" for more examples and options
  defp deps do
    [
      {:nostrum, "~> 0.2.1"},
      {:floki, "~> 0.15.0"},
      {:httpoison, "~> 0.11.1", override: true},
      {:distillery, "~> 1.2"},
      {:conform, "~> 2.3"},
      {:gun, git: "https://github.com/ninenines/gun.git", ref: "dd1bfe4d6f9fb277781d922aa8bbb5648b3e6756", override: true},
      {:websocket_client, "~> 1.3", override: true}
    ]
  end
end
