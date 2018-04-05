# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# Configures the endpoint
config :is_it_freeze, IsItFreezeWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "uwLJz1mCVG1jeWtXOKDYn5lieKCuEclHg8CRgIlVr/N0b00R8bBHGitEiRuAqG3X",
  render_errors: [view: IsItFreezeWeb.ErrorView, accepts: ~w(html json)],
  pubsub: [name: IsItFreeze.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:user_id]

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"
