defmodule Fields.PostcodeTest do
  use ExUnit.Case
  alias Fields.{Postcode, PostcodeEncrypted}

  describe "types" do
    test "Postcode.type is :string" do
      assert Postcode.type() == :string
    end

    test "PostcodeEncrypted.type is :binary" do
      assert PostcodeEncrypted.type() == :binary
    end
  end

  describe "cast" do
    test "Postcode.cast accepts a string" do
      assert {:ok, "EC4M 8AD"} == Postcode.cast("EC4M 8AD")
      assert {:ok, "E2 0SY"} == PostcodeEncrypted.cast("E2 0SY")
    end
  end

  describe "dump" do
    test "PostcodeEncrypted.dump encrypts a value" do
      {:ok, ciphertext} = PostcodeEncrypted.dump("E2 0SY")

      assert ciphertext != "E2 0SY"
      assert String.length(ciphertext) != 0
    end

    test "Postcode.dump returns a string" do
      assert {:ok, "EC4M 8AD"} == Postcode.dump("EC4M 8AD")
    end
  end

  describe "load" do
    test "PostcodeEncrypted.load decrypts a value" do
      {:ok, ciphertext} = PostcodeEncrypted.dump("E2 0SY")
      assert {:ok, "E2 0SY"} == PostcodeEncrypted.load(ciphertext)
    end

    test "Postcode.load returns a string" do
      assert {:ok, "EC4M 8AD"} == Postcode.load("EC4M 8AD")
    end
  end
end
