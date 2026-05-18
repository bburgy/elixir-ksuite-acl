defmodule KSuiteACL.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      KSuiteACLWeb.Telemetry,
      {DNSCluster, query: Application.get_env(:ksuite_acl, :dns_cluster_query) || :ignore},
      {Phoenix.PubSub, name: KSuiteACL.PubSub},
      # Start a worker by calling: KSuiteACL.Worker.start_link(arg)
      # {KSuiteACL.Worker, arg},
      # Start to serve requests, typically the last entry
      KSuiteACLWeb.Endpoint,
      KSuiteACL.State
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: KSuiteACL.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    KSuiteACLWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
