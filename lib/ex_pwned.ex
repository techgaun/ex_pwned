defmodule ExPwned do
  @moduledoc """
  ExPwned is a client library for Elixir to interact with [haveibeenpwned.com](https://haveibeenpwned.com/API/v2).
  """
  alias ExPwned.Breaches

  @doc """
  A convenience to check if an account has been breached or not.

  ## Example

      iex> ExPwned.breached?("abc@example.com")
      true
      iex> ExPwned.breached?("abcde@example.com")
      false
  """
  def breached?(account) do
    case Breaches.breachedaccount(account, [truncateResponse: true]) do
      {:ok, result, _} when length(result) > 0 -> true
      {:ok, %{msg: "no breach was found for given input"}, _} -> false
    end
  end
end
