defmodule ExPwned.Passwords do
  @moduledoc """
    Module to interact with hibp API to retrive breached passwords data.

    Notably, this functionality is provided by a different HIPB endpoint/URL,
    making it harder to share client code.
  """

  def breached_password?(password) do
    case breached_password_count(password) do
      0 -> false
      x when x > 0 -> true
      error -> {:error, error}
    end
  end

  def breached_password_count(password) do
    {partial_hash, hash_suffix} =
      password
      |> hash_sha1()
      |> String.split_at(5)

    call_api(partial_hash, hash_suffix)
  end

  defp hash_sha1(word) do
    :crypto.hash(:sha, word) |> Base.encode16
  end

  def call_api(partial_hash, hash_suffix) do
    case HTTPoison.get("https://api.pwnedpasswords.com/range/" <> partial_hash) do
      {:ok, %HTTPoison.Response{body: body, status_code: 200}} ->
        # Success.
        [_suffix, count] =
          body
          |> parse_body()
          |> Enum.find(["", "0"], &matches_suffix(&1, hash_suffix)) # default: ["", 0]

        count |> String.to_integer()
      {:ok, %HTTPoison.Response{body: body, status_code: 429}} ->
        {:error, body}
      other ->
        {:error, other}
    end
  end

  def parse_body(body) do
    body
    |> String.split(~r/\r\n/, trim: true)
    |> Enum.map(&to_tuple(&1))
  end

  def to_tuple(line) do
    line
    |> String.split(":")
  end

  def matches_suffix([line_suffix, _count], search_suffix) do
    line_suffix == search_suffix
  end

end
