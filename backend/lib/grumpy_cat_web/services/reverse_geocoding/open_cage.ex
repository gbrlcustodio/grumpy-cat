defmodule GrumpyCatWeb.ReverseGeocoding.OpenCage do
  @behaviour GrumpyCatWeb.ReverseGeocoding

  @moduledoc """
    Open Case implementation of reverse geocoding
  """

  @endpoint 'https://api.opencagedata.com/geocode/v1/json'
  @key Application.get_env(:grumpy_cat, :open_cage_secret)

  @impl GrumpyCatWeb.ReverseGeocoding
  def convert(latitude, longitude) do
    url = "#{@endpoint}?key=#{@key}&q=#{latitude}+#{longitude}&pretty=0&no_annotations=1"

    Application.ensure_all_started(:inets)
    Application.ensure_all_started(:ssl)

    String.to_charlist(url)
    |> :httpc.request()
    |> parse
    |> extract
  end

  defp parse({:ok, {{_protocol, 200, 'OK'}, _headers, body}}), do: {:ok, Jason.decode!(body)}
  defp parse(_response), do: :error

  defp extract(
        {:ok,
         %{
           "results" => [
             %{"components" => %{"country" => country, "state" => state, "city" => city}}
           ]
         }}
      ) do
    {:ok,
     %{
       "country" => country,
       "state" => state,
       "city" => city
     }}
  end

  defp extract(_content), do: {:error, 'no results found'}
end
