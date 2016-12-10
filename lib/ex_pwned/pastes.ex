defmodule ExPwned.Pastes do
  @moduledoc """
  Module to interact with hibp API to retrive breaches data
  """

  use ExPwned.Api

  @doc """
  The API takes a single parameter which is the email address to be searched for.
  Unlike searching for breaches, usernames that are not email addresses cannot be searched for.
  The email is not case sensitive and will be trimmed of leading or trailing white spaces.
  The email should always be URL encoded.

  ## Examples

      iex> ExPwned.Pastes.pasteaccount("abc@example.com")
  """
  def pasteaccount(account), do: do_get("pasteaccount/#{account}")
end
