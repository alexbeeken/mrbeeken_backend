defmodule MrbeekenBackendWeb.Errors do
  @moduledoc """
    Stores error messages and has error rendering for controllers
    if needed.
  """

  import Plug.Conn
  import Phoenix.Controller

  alias MrbeekenBackendWeb.ErrorView

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

  @not_allowed "you dont have permission to do that"
  def not_allowed, do: @not_allowed

  @session_bad "your session is no longer valid"
  def password_bad, do: @session_bad

  def render_error(conn, status, message) do
    conn
    |> put_status(status)
    |> render(ErrorView, "#{status}.json-api", %{title: message})
    |> halt()
  end
end
