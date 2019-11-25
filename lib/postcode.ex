defmodule Fields.Postcode do
  @moduledoc """
  An Ecto Type for plaintext postcodes.
  Use for publicly available postcodes. For personal data, use `Fields.PostcodeEncrypted` instead.

  ## Example

      schema "retailers" do
        field(:postcode, Fields.Postcode)
      end
  """
  alias Fields.Validate

  @behaviour Ecto.Type

  def type, do: :string

  def cast(value) do
    value = value |> to_string() |> String.trim()
    {:ok, value}
  end

  def dump(value) do
    {:ok, to_string(value)}
  end

  def load(value) do
    {:ok, value}
  end

  def embed_as(_value), do: :dump

  def equal?(a, b), do: a == b
end
