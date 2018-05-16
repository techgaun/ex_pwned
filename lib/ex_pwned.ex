defmodule ExPwned do
  @moduledoc """
  ExPwned is a client library for Elixir to interact with [haveibeenpwned.com](https://haveibeenpwned.com/API/v2).
  """
  alias ExPwned.Breaches
  alias ExPwned.Passwords

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

  @doc """
    Returns true if this password has been seen in a data breach on Have I Been Pwned

    ## Example

      iex> ExPwned.password_breached?("123456")
      true
      iex> ExPwned.password_breached?("correcthorsebatterystaplexkcdrules")
      false
  """
  def password_breached?(password) do
    Passwords.breached?(password)
  end

  @doc """
    Returns the number of times a password has been seen in a data breach. It will
    return zero if the password has not yet been found in a breach.

    ## Example

      iex> ExPwned.password_breach_count("123456")
      20760336
      iex> ExPwned.password_breach_count("correcthorsebatterystaplexkcdrules")
      0
  """
  def password_breach_count(password) do
    Passwords.password_breach_count(password)
  end

end
