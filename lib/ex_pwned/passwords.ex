defmodule ExPwned.Passwords do
  @moduledoc """
    Module to interact with hibp API to retrive breached passwords data.
  """

  def breached?(password) do
    case password_breach_count(password) do
      0 -> false
      x when x > 0 -> true
      {:error, error} -> {:error, error}
      unexpected -> unexpected
    end
  end

  def password_breach_count(password) do
    {partial_hash, hash_suffix} =
      password
      |> hash_sha1()
      |> String.split_at(5)

    call_api(partial_hash, hash_suffix)
  end

  def call_api(partial_hash, hash_suffix) do
    case HTTPoison.get("https://api.pwnedpasswords.com/range/" <> partial_hash) do
      {:ok, %HTTPoison.Response{body: body, status_code: 200}} ->
        handle_success(body, hash_suffix)
      {:ok, %HTTPoison.Response{body: body, status_code: 429}} ->
        {:error, body}
      other ->
        {:error, other}
    end
  end

  def handle_success(body, hash_suffix) do
    [_suffix, count] =
      body
      |> parse_body()
      |> Enum.find(["", "0"], &matches_suffix(&1, hash_suffix)) # default: ["", "0"]

    count |> String.to_integer()
  end

  def parse_body(body) do
    body
    |> String.split(~r/\r\n/, trim: true)
    |> Enum.map(&String.split(&1, ":"))
  end

  defp matches_suffix([line_suffix, _count], search_suffix) do
    line_suffix == search_suffix
  end

  defp hash_sha1(word) do
    :crypto.hash(:sha, word) |> Base.encode16
  end

end
