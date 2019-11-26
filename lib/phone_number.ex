defmodule Fields.PhoneNumber do
  @moduledoc """
  An Ecto Type for plaintext phone numbers.
  Useful for publicly available numbers such as customer support.
  See `Fields.PhoneNumberEncrypted` for storing numbers that are Personally Identifiable Information.

  ## Example

        schema "retailers" do
          field(:phone_number, Fields.PhoneNumber)
        end
  """

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
