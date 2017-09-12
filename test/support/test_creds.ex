defmodule TestCreds do
  @valid_token "Bearer 12345"
  def valid_token, do: @valid_token

  @invalid_token "Bearer 123456"
  def invalid_token, do: @invalid_token
end
