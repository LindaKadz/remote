defmodule Remote.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  def start(_type, _args) do
    children = [
      # Start the Ecto repository
      Remote.Repo,
      # Start the Telemetry supervisor
      RemoteWeb.Telemetry,
      # Start the PubSub system
      {Phoenix.PubSub, name: Remote.PubSub},
      # Start the Endpoint (http/https)
      RemoteWeb.Endpoint,
      # Start our server
      Remote.Server
      # Start a worker by calling: Remote.Worker.start_link(arg)
      # {Remote.Worker, arg}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Remote.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  def config_change(changed, _new, removed) do
    RemoteWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
