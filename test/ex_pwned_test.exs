defmodule ExPwnedTest do
  use ExUnit.Case

  test "password_breached?/1" do
    assert true == ExPwned.password_breached?("123456")
  end

  test "password_breach_count/1" do
    result = ExPwned.password_breach_count("123456")
    assert result > 0
  end
end
