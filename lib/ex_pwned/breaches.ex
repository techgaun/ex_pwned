defmodule ExPwned.Breaches do
  @moduledoc """
  Module to interact with hibp API to retrive breaches data
  """

  use ExPwned.Api

  @doc """
  return a list of all breaches a particular account has been involved in.
  The API takes a single parameter which is the account to be searched for.
  The account is not case sensitive and will be trimmed of leading or trailing white spaces.
  The account should always be URL encoded.

  ## Examples

      iex> ExPwned.Breaches.breachedaccount("abc@example.com")
      iex> ExPwned.Breaches.breachedaccount("abc@example.com", [truncateResponse: true, domain: "adobe.com"])
  """
  def breachedaccount(account, opts \\ []), do: do_get("breachedaccount/#{account}", opts)

  @doc """
  Get all breaches in hibp.

  ## Examples

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
  """
  def breaches, do: do_get("breaches")

  @doc """
  Filters the result set to only breaches against the domain specified

  ## Example

      iex> ExPwned.Breaches.breaches("000webhost.com")
      {:ok,
       [%{"AddedDate" => "2015-10-26T23:35:45Z", "BreachDate" => "2015-03-01",
          "DataClasses" => ["Email addresses", "IP addresses", "Names", "Passwords"],
          "Description" => "In approximately March 2015, the free web hosting provider <a href=\"http://www.troyhunt.com/2015/10/breaches-traders-plain-text-passwords.html\" target=\"_blank\" rel=\"noopener\">000webhost suffered a major data breach</a> that exposed over 13 million customer records. The data was sold and traded before 000webhost was alerted in October. The breach included names, email addresses and plain text passwords.",
          "Domain" => "000webhost.com", "IsActive" => true, "IsRetired" => false,
          "IsSensitive" => false, "IsSpamList" => false, "IsVerified" => true,
          "LogoType" => "png", "Name" => "000webhost", "PwnCount" => 13545468,
          "Title" => "000webhost"}], [retry_after: 0]}
  """
  def breaches(domain), do: do_get("breaches", %{domain: domain})

  @doc """
  Sometimes just a single breach is required and this can be retrieved by the breach "name".
  This is the stable value which may or may not be the same as the breach "title" (which can change).

  ## Example

      iex> ExPwned.Breaches.breach("000webhost")
      {:ok,
       %{"AddedDate" => "2015-10-26T23:35:45Z", "BreachDate" => "2015-03-01",
         "DataClasses" => ["Email addresses", "IP addresses", "Names", "Passwords"],
         "Description" => "In approximately March 2015, the free web hosting provider <a href=\"http://www.troyhunt.com/2015/10/breaches-traders-plain-text-passwords.html\" target=\"_blank\" rel=\"noopener\">000webhost suffered a major data breach</a> that exposed over 13 million customer records. The data was sold and traded before 000webhost was alerted in October. The breach included names, email addresses and plain text passwords.",
         "Domain" => "000webhost.com", "IsActive" => true, "IsRetired" => false,
         "IsSensitive" => false, "IsSpamList" => false, "IsVerified" => true,
         "LogoType" => "png", "Name" => "000webhost", "PwnCount" => 13545468,
         "Title" => "000webhost"}, [retry_after: 0]}
  """
  def breach(name), do: do_get("breach/#{name}")

  @doc """
  A "data class" is an attribute of a record compromised in a breach.
  For example, many breaches expose data classes such as "Email addresses" and "Passwords".
  The values returned by this service are ordered alphabetically in a string array
  and will expand over time as new breaches expose previously unseen classes of data.

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
  """
  def dataclasses, do: do_get("dataclasses")
end
