<div align="center">

# Fields

A collection of commonly used fields implemented as custom Ecto types 
with the necessary validation, encryption, and/or hashing.

[![Build Status](https://img.shields.io/travis/dwyl/fields/master.svg?style=flat-square)](https://travis-ci.org/dwyl/fields)
[![contributions welcome](https://img.shields.io/badge/contributions-welcome-brightgreen.svg?style=flat-square)](https://github.com/dwyl/fields/issues)
[![HitCount](http://hits.dwyl.io/dwyl/fields.svg)](http://hits.dwyl.io/dwyl/fields)
<!-- uncomment when service is working ... [![Inline docs](http://inch-ci.org/github/dwyl/fields.svg?branch=master&style=flat-square)](http://inch-ci.org/github/dwyl/fields) 
[![codecov.io](https://img.shields.io/codecov/c/github/dwyl/fields/master.svg?style=flat-square)](http://codecov.io/github/dwyl/fields?branch=master)
-->

  <a href="https://youtu.be/8UQK-UcRezE"
  alt="Try the Demo on Heroku!">
    <img src="https://user-images.githubusercontent.com/194400/57781239-af4a0280-7721-11e9-8bf0-42bee626f58a.png"
    alt="Van Gogh Fields of Wheat!">
  </a>

</div>





## Installation

If [available in Hex](https://hex.pm/docs/publish), the package can be installed
by adding `fields` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [
    {:fields, "~> 0.1.2"}
  ]
end
```

Documentation can be generated with [ExDoc](https://github.com/elixir-lang/ex_doc)
and published on [HexDocs](https://hexdocs.pm). Once published, the docs can
be found at [https://hexdocs.pm/fields](https://hexdocs.pm/fields).

## Usage

Each field can be used in place of an Ecto type when defining your schema.

```
schema "users" do
  field(:email, Fields.EmailEncrypted)
  field(:address, Fields.Address)
  field(:postcode, Fields.Postcode)
  field(:password, Fields.Password)

  timestamps()
end
```

Each field is defined as an [Ecto type](https://hexdocs.pm/ecto/Ecto.Type.html), with the relevant callbacks. So when you call `Ecto.Changeset.cast/4` in your schema's changeset function, the field will be correctly validated. For example, calling cast on the `:email` field will ensure it is a valid format for an email address.

When you load one of the fields into your database, the corresponding `dump/1` callback will be called, ensuring it is inserted into the database in the correct format. In the case of `Fields.EmailEncrypted`, it will encrypt the email address using a give encryption key (set in your config file) before inserting it.

Likewise, when you load a field from the database, the `load/1` callback will be called, giving you the data in the format you need. `Fields.EmailEncrypted` will be decrypted back to plaintext.

Each Field optionally defines an `input_type/0` function. This will return an atom representing the `Phoenix.HTML.Form` input type to use for the Field. For example, `Fields.DescriptionPlaintextUnlimited.input_type` returns `:textarea`.

The fields `DescriptionPlaintextUnlimited` and `HtmlBody` use html_sanitize_ex
(https://github.com/rrrene/html_sanitize_ex) to remove scripts and help keep your
project safe. `HtmlBody` is able to display basic html elements whilst
`DescriptionPlaintextUnlimited` displays text. Remember to use `raw` when rendering
the content of your `DescriptionPlaintextUnlimited` and `HtmlBody` fields so that
symbols such as & (ampersand) and Html are rendered correctly. E.g.
`<p><%= raw @product.description %></p>` 

The currently existing fields are:

- [Address](lib/address.ex)
- [AddressEncrypted](lib/address_encrypted.ex)
- [DescriptionPlaintextUnlimited](lib/description_plaintext_unlimited.ex)
- [Encrypted](lib/encrypted.ex)
- [EmailPlaintext](lib/email_plaintext.ex)
- [EmailHash](lib/email_hash.ex)
- [EmailEncrypted](lib/email_encrypted.ex)
- [Hash](lib/hash.ex)
- [HtmlBody](lib/html-body.ex)
- [Password](lib/password.ex)
- [PhoneNumber](lib/phone_number.ex)
- [PhoneNumberEncrypted](lib/phone_number_encrypted.ex)
- [Postcode](lib/postcode.ex)
- [PostcodeEncrypted](lib/postcode_encrypted.ex)
- [Url](lib/url.ex)


## Config

If you use any of the `Encrypted` fields, you will need to set a list of one or more encryption keys in your config:

``` elixir
config :fields, Fields.AES,
  keys:
    System.get_env("ENCRYPTION_KEYS")
    # remove single-quotes around key list in .env
    |> String.replace("'", "")
    # split the CSV list of keys
    |> String.split(",")
    # decode the key.
    |> Enum.map(fn key -> :base64.decode(key) end)
```

If you use any of the `Hash` fields, you will need to set a secret key base:

``` elixir
config :fields, Fields,
  secret_key_base: "rVOUu+QTva+VlRJJI3wSYONRoffFQH167DfiZcegvYY/PEasjPLKIDz7wPTvTPIP"
```

## Background / Further Reading


### How to Create a Re-useable Elixir Package and Publish to `hex.pm`
+ https://hex.pm/docs/publish
+ https://medium.com/kkempin/how-to-create-and-publish-hex-pm-package-elixir-90cb33e2592d
+ https://medium.com/blackode/how-to-write-elixir-packages-and-publish-to-hex-pm-8723038ebe76

### How to _Use_ the Package Locally _Before_ Publishing it to `hex.pm`

+ https://stackoverflow.com/questions/28185003/using-a-package-locally-with-hex-pm
