# ExPwned

[![Hex version](https://img.shields.io/hexpm/v/ex_pwned.svg "Hex version")](https://hex.pm/packages/ex_pwned) ![Hex downloads](https://img.shields.io/hexpm/dt/ex_pwned.svg "Hex downloads")

> Elixir client for haveibeenpwned.com

## Installation

The package can be installed as:

1. Add `ex_pwned` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [{:ex_pwned, "~> 0.1.0"}]
end
```

2. Ensure `ex_pwned` is started before your application:

```elixir
def application do
  [applications: [:ex_pwned]]
end
```

## Configuration

You can set the user agent for ExPwned (defaults to `ExPwned Elixir Client`) by specifying user agent in config.

```elixir
config :ex_pwned,
  user_agent: "ExMustang Slackbot"
```

You can configure the json library to use for decoding body. By default, it is set to Jason.
The json library is supposed to have implemented `decode!/1`.

```elixir
config :ex_pwned,
  json_library: Poison
```

## Usage

Using `ExPwned` is simple.

#### Check if an account is breached or not

```elixir
iex> ExPwned.breached?("abc@example.com")
true
```

#### Check if a password is breached, and how many times
```elixir
# True/False Check
iex> ExPwned.password_breached?("password123")
true

# Returns # of times password was seen in a breach. Zero if none.
iex> ExPwned.password_breach_count("password123")
5032
```

#### Check the breaches for an account

```elixir
iex> ExPwned.Breaches.breachedaccount("abc@example.com")
{:ok,
 [%{"AddedDate" => "2015-10-26T23:35:45Z", "BreachDate" => "2015-03-01",
    "DataClasses" => ["Email addresses", "IP addresses", "Names", "Passwords"],
    "Description" => "In approximately March 2015, the free web hosting provider <a href=\"http://www.troyhunt.com/2015/10/breaches-traders-plain-text-passwords.html\" target=\"_blank\" rel=\"noopener\">000webhost suffered a major data breach</a> that exposed over 13 million customer records. The data was sold and traded before 000webhost was alerted in October. The breach included names, email addresses and plain text passwords.",
    "Domain" => "000webhost.com", "IsActive" => true, "IsRetired" => false,
    "IsSensitive" => false, "IsSpamList" => false, "IsVerified" => true,
    "LogoType" => "png", "Name" => "000webhost", "PwnCount" => 13545468,
    "Title" => "000webhost"}], [retry_after: 0]}

iex> ExPwned.Breaches.breachedaccount("abc@example.com", [truncateResponse: true, domain: "adobe.com"])
{:ok, [%{"Name" => "000webhost"}], [retry_after: 0]}
```

#### Get all available breaches

```elixir
iex> ExPwned.Breaches.breaches
{:ok,
[%{"AddedDate" => "2015-10-26T23:35:45Z", "BreachDate" => "2015-03-01",
    "DataClasses" => ["Email addresses", "IP addresses", "Names", "Passwords"],
    "Description" => "In approximately March 2015, the free web hosting provider <a href=\"http://www.troyhunt.com/2015/10/breaches-traders-plain-text-passwords.html\" target=\"_blank\" rel=\"noopener\">000webhost suffered a major data breach</a> that exposed over 13 million customer records. The data was sold and traded before 000webhost was alerted in October. The breach included names, email addresses and plain text passwords.",
    "Domain" => "000webhost.com", "IsActive" => true, "IsRetired" => false,
    "IsSensitive" => false, "IsSpamList" => false, "IsVerified" => true,
    "LogoType" => "png", "Name" => "000webhost", "PwnCount" => 13545468,
    "Title" => "000webhost"},
  [retry_after: 0]
}

# or breaches for specific domain
iex> ExPwned.Breaches.breaches("000webhost.com")
{:ok,
 [%{"AddedDate" => "2015-10-26T23:35:45Z", "BreachDate" => "2015-03-01",
    "DataClasses" => ["Email addresses", "IP addresses", "Names", "Passwords"],
    "Description" => "In approximately March 2015, the free web hosting provider <a href=\"http://www.troyhunt.com/2015/10/breaches-traders-plain-text-passwords.html\" target=\"_blank\" rel=\"noopener\">000webhost suffered a major data breach</a> that exposed over 13 million customer records. The data was sold and traded before 000webhost was alerted in October. The breach included names, email addresses and plain text passwords.",
    "Domain" => "000webhost.com", "IsActive" => true, "IsRetired" => false,
    "IsSensitive" => false, "IsSpamList" => false, "IsVerified" => true,
    "LogoType" => "png", "Name" => "000webhost", "PwnCount" => 13545468,
    "Title" => "000webhost"}], [retry_after: 0]}
```

#### Get specific breach detail

```elixir
iex> ExPwned.Breaches.breach("000webhost")
{:ok,
 %{"AddedDate" => "2015-10-26T23:35:45Z", "BreachDate" => "2015-03-01",
   "DataClasses" => ["Email addresses", "IP addresses", "Names", "Passwords"],
   "Description" => "In approximately March 2015, the free web hosting provider <a href=\"http://www.troyhunt.com/2015/10/breaches-traders-plain-text-passwords.html\" target=\"_blank\" rel=\"noopener\">000webhost suffered a major data breach</a> that exposed over 13 million customer records. The data was sold and traded before 000webhost was alerted in October. The breach included names, email addresses and plain text passwords.",
   "Domain" => "000webhost.com", "IsActive" => true, "IsRetired" => false,
   "IsSensitive" => false, "IsSpamList" => false, "IsVerified" => true,
   "LogoType" => "png", "Name" => "000webhost", "PwnCount" => 13545468,
   "Title" => "000webhost"}, [retry_after: 0]}
```

#### Get all data classes for breaches

```elixir
iex> ExPwned.Breaches.dataclasses
{:ok,
 ["Account balances", "Age groups", "Astrological signs", "Avatars",
  "Bank account numbers", "Banking PINs", "Beauty ratings", "Biometric data",
  "Browser user agent details", "Car ownership statuses", "Career levels",
  "Chat logs", "Credit card CVV", "Credit cards", "Credit status information",
  "Customer feedback", "Customer interactions", "Dates of birth",
  "Deceased date", "Device information", "Device usage tracking data",
  "Drinking habits", "Drug habits", "Education levels", "Email addresses",
  "Email messages", "Employers", "Ethnicities", "Family members' names",
  "Family plans", "Family structure", "Financial transactions",
  "Fitness levels", "Genders", "Geographic locations", "Government issued IDs",
  "Historical passwords", "Home ownership statuses", "Homepage URLs",
  "Income levels", "Instant messenger identities", "IP addresses", "Job titles",
  "MAC addresses", "Marital statuses", "Names", "Nicknames", "Parenting plans",
  ...], [retry_after: 0]}
```

#### Get the pastes for an account

```elixir
iex> ExPwned.Pastes.pasteaccount("abc@example.com")
{:ok,
 [%{"Date" => nil, "EmailCount" => 4788657,
    "Id" => "https://pred.me/gmail.html", "Source" => "AdHocUrl",
    "Title" => "pred.me"}], [retry_after: 0]}
```

### Response

The response follows following patterns:

```elixir
# result found
{:ok, result, [retry_after: seconds_value]}

# no breach
{:ok, %{msg: "no breach was found for given input"}, [retry_after: seconds_value]}

# for errors, the third arg is status code instead

# 400 bad request
{:error, "bad request - the parameter does not comply with an acceptable format", 400}

# 403 forbidden
{:error, "no user agent has been specified in the request", 403}
```
