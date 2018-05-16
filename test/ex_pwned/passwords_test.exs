defmodule ExPwned.PasswordsTest do
  use ExUnit.Case
  alias ExPwned.Passwords

  test "handle_success/2 with breached passwords" do
    body = "00387259BECFC8B3CB0D27EBDDC2AC93758:1\r\n00BA633D4B050924FA8228526CE0F561B38:3"
    assert 1 === Passwords.handle_success(body, "00387259BECFC8B3CB0D27EBDDC2AC93758")
    assert 3 === Passwords.handle_success(body, "00BA633D4B050924FA8228526CE0F561B38")
  end

  test "handle_success/2 with hash not found" do
    body = "00387259BECFC8B3CB0D27EBDDC2AC93758:1\r\n00BA633D4B050924FA8228526CE0F561B38:3"
    assert 0 === Passwords.handle_success(body, "NOTFOUND")
  end

  test "handle_success/2 with only one response" do
    body = "00387259BECFC8B3CB0D27EBDDC2AC93758:1"
    assert 1 === Passwords.handle_success(body, "00387259BECFC8B3CB0D27EBDDC2AC93758")
  end

  test "parse_body/1" do
    body = "00387259BECFC8B3CB0D27EBDDC2AC93758:1\r\n00BA633D4B050924FA8228526CE0F561B38:3"
    hash_suffix = "259BECFC8B3CB0D27EBDDC2AC93758"

    result = Passwords.parse_body(body)
    assert is_list(result)
    assert ["00387259BECFC8B3CB0D27EBDDC2AC93758", "1"] in result
    assert ["00BA633D4B050924FA8228526CE0F561B38", "3"] in result
  end

end
