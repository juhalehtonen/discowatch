# Import all plugins from `rel/plugins`
# They can then be used by adding `plugin MyPlugin` to
# either an environment, or release definition, where
# `MyPlugin` is the name of the plugin module.
Path.join(["rel", "plugins", "*.exs"])
|> Path.wildcard()
|> Enum.map(&Code.eval_file(&1))

use Mix.Releases.Config,
    # This sets the default release built by `mix release`
    default_release: :default,
    # This sets the default environment used by `mix release`
    default_environment: Mix.env()

# For a full list of config options for both releases
# and environments, visit https://hexdocs.pm/distillery/configuration.html


# You may define one or more environments in this file,
# an environment's settings will override those of a release
# when building in that environment, this combination of release
# and environment configuration is called a profile

environment :dev do
  set dev_mode: true
  set include_erts: false
  set cookie: :"2!2@s.:1.~8]_Pa,}W7{pz<m)n:Vq1)tDAVU;)GeBw)i049C3i1tq_oXrBal12H;"
end

# Make sure :include_erts is set to true if you want to include Erlang
environment :prod do
  set include_erts: true
  set include_src: false
  set cookie: :crypto.hash(:sha256, System.get_env("DISCOWATCH_COOKIE")) |> Base.encode16 |> String.to_atom
end

# You may define one or more releases in this file.
# If you have not set a default release, or selected one
# when running `mix release`, the first release in the file
# will be used by default


# Get current version from mix.exs and set the output directory
release :discowatch do
  set version: current_version(:discowatch)
  set output_dir: './releases/discowatch'
  set applications: [
    :runtime_tools
  ]
  plugin Conform.ReleasePlugin
end
