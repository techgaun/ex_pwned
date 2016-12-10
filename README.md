# ExPwned

> Elixir client for haveibeenpwned.com

## Installation

The package can be installed as:

1. Add `ex_pwned` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [{:ex_pwned, "~> 0.1.0"}]
end
```

2. Ensure `ex_pwned` is started before your application:

```elixir
def application do
  [applications: [:ex_pwned]]
end
```

## Configuration

You can set the user agent for ExPwned (defaults to `ExPwned Elixir Client`) by specifying user agent in config.

```elixir
config :ex_pwned,
  user_agent: "ExMustang Slackbot"
```
