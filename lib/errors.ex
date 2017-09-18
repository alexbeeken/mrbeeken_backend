defmodule MrbeekenBackendWeb.Errors do
  @password_bad "password is incorrect"
  def password_bad, do: @password_bad

  @token_missing "authorization header not found"
  def token_missing, do: @token_missing

  @token_format_bad "authorization token incorrectly formatted"
  def token_format_bad, do: @token_format_bad

  @token_invalid "authorization token invalid"
  def token_invalid, do: @token_invalid

  @unnacceptable_type "accept header needs to have correct type"
  def unnacceptable_type, do: @unnacceptable_type

  @missing_param "missing a required field"
  def missing_param, do: @missing_param

  @user_not_found "email does not exist"
  def user_not_found, do: @user_not_found
end
