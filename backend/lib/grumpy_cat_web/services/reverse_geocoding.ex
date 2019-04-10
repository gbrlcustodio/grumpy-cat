defmodule GrumpyCatWeb.ReverseGeocoding do
  @moduledoc """
  Defines reverse geocoding behaviour.
  """

  @type location :: %{country: String.t(), state: String.t(), city: String.t()}

  @doc """
  Converts a given latitude/longitude location to its address based position

  ## Examples

      iex> convert(51.952659, 7.632473)
      %{country: "Germany", state: "North Rhine-Westphalia", city: "Münster"}

  """
  @callback convert(latitude :: float, longitude :: float) :: {:ok, location} | {:error, term}
end
