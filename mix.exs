defmodule Promex.Mixfile do
  use Mix.Project

  def project do
    [
      app: :promex,
      version: "0.0.1",
      elixir: "~> 1.2",
      build_embedded: Mix.env == :prod,
      start_permanent: Mix.env == :prod,
      deps: deps
    ]
  end

  def application do
    [
      applications: [:logger, :cowboy],
      mod: {Promex, []}
    ]
  end

  defp deps do
    [
      {:cowboy, "~> 1.0"}
    ]
  end
end