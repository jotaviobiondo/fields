defmodule Fields.EmailHash do
  @moduledoc """
  An Ecto Type for hashed emails.
  Use in conjuction with `Fields.EmailEncrypted` in order to be able to look up database rows by email.
  Hashed using sha256. See `Fields.Helpers` for hashing details.

  ## Example

      schema "users" do
        field(:email, Fields.EmailEncrypted)
        field(:email_hash, Fields.EmailHash)
      end
  """
  alias Fields.{EmailPlaintext, Hash}

  @behaviour Ecto.Type

  def type, do: :binary

  def cast(value), do: EmailPlaintext.cast(value)

  def dump(value), do: Hash.dump(value)

  def load(value) do
    {:ok, value}
  end

  def embed_as(_value), do: :dump

  def equal?(a, b), do: a == b
end
