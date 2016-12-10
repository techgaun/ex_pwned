defmodule ExPwned.Breaches do
  @moduledoc """
  Module to interact with hibp API to retrive breaches data
  """

  use ExPwned.Api

  @doc """
  return a list of all breaches a particular account has been involved in.
  The API takes a single parameter which is the account to be searched for.
  The account is not case sensitive and will be trimmed of leading or trailing white spaces.
  The account should always be URL encoded.

  ## Examples

      iex> ExPwned.Breaches.breachedaccount("abc@example.com")
      iex> ExPwned.Breaches.breachedaccount("abc@example.com", [truncateResponse: true, domain: "adobe.com"])
  """
  def breachedaccount(account, opts \\ []), do: do_get("breachedaccount/#{account}", opts)

  @doc """
  Get all breaches in hibp.
  """
  def breaches, do: do_get("breaches")

  @doc """
  Filters the result set to only breaches against the domain specified
  """
  def breaches(domain), do: do_get("breaches", %{domain: domain})

  @doc """
  Sometimes just a single breach is required and this can be retrieved by the breach "name".
  This is the stable value which may or may not be the same as the breach "title" (which can change).
  """
  def breach(name), do: do_get("breach/#{name}")

  @doc """
  A "data class" is an attribute of a record compromised in a breach.
  For example, many breaches expose data classes such as "Email addresses" and "Passwords".
  The values returned by this service are ordered alphabetically in a string array
  and will expand over time as new breaches expose previously unseen classes of data.
  """
  def dataclasses, do: do_get("dataclasses")
end
