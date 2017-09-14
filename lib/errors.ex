defmodule MrbeekenBackendWeb.Errors do
  @password_bad "Password is incorrect"
  def password_bad, do: @password_bad

  @session_bad "Session not found"
  def session_bad, do: @session_bad

  @unnacceptable_type "Accept header needs to have correct type"
  def unnacceptable_type, do: @unnacceptable_type

  @missing_param "Missing a required field"
  def missing_param, do: @missing_param

  @user_not_found "Email does not exist"
  def user_not_found, do: @user_not_found
end
