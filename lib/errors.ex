defmodule MrbeekenBackendWeb.Errors do
  @password_bad "Password is incorrect"
  def password_bad, do: @password_bad

  @session_bad "Session not found"
  def session_bad, do: @session_bad
end
