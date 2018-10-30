defmodule ExPwnedTest do
  use ExUnit.Case

  describe "password_breached?/1" do
    test "Known breached password" do
      assert true == ExPwned.password_breached?("123456")
    end
    test "Probably good password" do
      assert false == ExPwned.password_breached?(UUID.uuid1())
    end
  end

  describe "password_breach_count?/1" do
    test "Known breached password" do
      result = ExPwned.password_breach_count("123456")
      assert result > 0
    end
    test "Probably good password" do
      result = ExPwned.password_breach_count(UUID.uuid1())
      assert result == 0
    end
  end

  describe "breached?/1" do
    test "Known breached account" do
      assert true == ExPwned.breached?("test@example.com")
    end
    test "Probably good account" do
      assert false == ExPwned.breached?("#{UUID.uuid1()}@example.com")
    end
  end
end
