defmodule ExPwned.Utils do
  @moduledoc """
  Collection of helper functions for ExPwned
  """

  def ua,
    do: {"User-Agent", Application.get_env(:ex_pwned, :user_agent) || "ExPwned Elixir Client"}

  def api_version, do: {"api-version", 2}
  def headers, do: [ua(), api_version()]
  def base_url, do: "https://haveibeenpwned.com/api/"
end
