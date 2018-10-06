defmodule ExPwned.Parser do
  @moduledoc """
  Generic parser to parse all the api responses
  """

  @doc """
  Parses the response from hibp API calls
  """
  def parse(response) do
    case response do
      {:ok, %HTTPoison.Response{body: body, headers: headers, status_code: 200}} ->
        {:ok, parse_success_response(body), process_headers(headers)}

      {:ok, %HTTPoison.Response{body: _body, headers: headers, status_code: 404}} ->
        {:ok, %{msg: "no breach was found for given input"}, process_headers(headers)}

      {:ok, %HTTPoison.Response{body: _, headers: _, status_code: 400}} ->
        {:error, "bad request - the parameter does not comply with an acceptable format", 400}

      {:ok, %HTTPoison.Response{body: _, headers: _, status_code: 403}} ->
        {:error, "no user agent has been specified in the request", 403}

      {:ok, %HTTPoison.Response{body: _, headers: headers, status_code: 429}} ->
        m = Enum.into(headers, %{})
        retry_seconds = Map.fetch!(m, "Retry-After")
        {:ok, :retry, retry_seconds}

      {:ok, %HTTPoison.Response{body: body, headers: _, status_code: status}} ->
        {:error, body, status}

      {:error, %HTTPoison.Error{id: _, reason: reason}} ->
        {:error, reason, -1}

      _ ->
        response
    end
  end

  defp parse_success_response(body), do: body |> Poison.decode!()

  defp process_headers(headers) when is_list(headers) and length(headers) > 0 do
    {_, retry_after} = List.keyfind(headers, "Retry-After", 0, {nil, "0"})
    [retry_after: String.to_integer(retry_after)]
  end

  defp process_headers(_), do: [retry_after: 0]
end
