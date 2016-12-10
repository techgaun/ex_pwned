defmodule ExPwned.Api do
  @moduledoc """
  Base definition for Api client
  """

  defmacro __using__(_opts) do
    quote do
      alias ExPwned.Parser
      import ExPwned.Utils

      def build_url(path_arg, query_params \\ %{}) do
        "#{base_url}/#{path_arg}?#{URI.encode_query(query_params)}"
      end

      def do_get(path_arg), do: do_get(path_arg, %{})
      def do_get(path_arg, query_params) when is_list(query_params), do: do_get(path_arg, Enum.into(query_params, %{}))
      def do_get(path_arg, query_params) do
        path_arg
        |> build_url(query_params)
        |> HTTPoison.get(headers)
        |> Parser.parse
      end
    end
  end
end
