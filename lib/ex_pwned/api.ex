defmodule ExPwned.Api do
  @moduledoc """
  Base definition for Api client
  """

  defmacro __using__(_opts) do
    quote do
      alias ExPwned.Parser
      import ExPwned.Utils

      def build_url(path_arg, query_params \\ %{}) do
        "#{base_url()}/#{path_arg}?#{URI.encode_query(query_params)}"
      end

      def do_get(path_arg), do: do_get(path_arg, %{})

      def do_get(path_arg, query_params) when is_list(query_params),
        do: do_get(path_arg, Enum.into(query_params, %{}))

      def do_get(path_arg, query_params) do
        {:ok, result, status} =
          path_arg
          |> build_url(query_params)
          |> HTTPoison.get(headers())
          |> Parser.parse()

        case result do
          :retry ->
            # the server sent us a Retry-After header
            # status is in Seconds
            {sleep_time, _} = Integer.parse(status)
            :timer.sleep(sleep_time * 1000)
            do_get(path_arg, query_params)

          _ ->
            {:ok, result, status}
        end
      end
    end
  end
end
