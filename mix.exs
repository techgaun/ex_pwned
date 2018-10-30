defmodule ExPwned.Mixfile do
  use Mix.Project

  def project do
    [
      app: :ex_pwned,
      version: "0.1.4",
      elixir: "~> 1.3",
      description: "Elixir client for haveibeenpwned.com",
      source_url: "https://github.com/techgaun/ex_pwned",
      package: package(),
      build_embedded: Mix.env() == :prod,
      start_permanent: Mix.env() == :prod,
      docs: [extras: ["README.md"]],
      deps: deps()
    ]
  end

  def application do
    [applications: [:logger, :httpoison]]
  end

  defp deps do
    [
      {:httpoison, "~> 0.9 or ~> 0.10"},
      {:poison, "~> 2.0 or ~> 3.0"},
      {:ex_doc, "~> 0.19", only: :dev},
      {:uuid, "~> 1.1", only: :test},
      {:credo, "~> 0.10.2", only: [:dev, :test], runtime: false}
    ]
  end

  defp package do
    [
      maintainers: [
        "Samar Acharya"
      ],
      licenses: ["Apache-2.0"],
      links: %{"GitHub" => "https://github.com/techgaun/ex_pwned"}
    ]
  end
end
