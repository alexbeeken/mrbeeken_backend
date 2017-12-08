defmodule MrbeekenBackendWeb.TestCreds do
  @moduledoc """
    This is used to abstract user and login params so that future
    changes to the login or registration process can also be reflected
    in this single place.
  """

  alias MrbeekenBackendWeb.User

  @user_attrs %{
    email: "test@example.com",
    password: "123456abc",
    password_confirmation: "123456abc"
  }
  def user_attrs, do: @user_attrs

  def valid_login_params(
    user \\ %User{
      email: "test@example.com",
      password: "123456abc"}
    ) do
    %{email: user.email, password: user.password}
  end

  def valid_registration_params(
    user \\ %User{
      email: "test@example.com",
      password: "123456abc",
      password_hash: "123456abc"}
      ) do
    %{
      email: user.email,
      password: user.password,
      password_hash: user.password_hash
    }
  end

  def bad_password_login_params(
    user \\ %User{
      email: "test@example.com",
      password: "123456abc"}
      ) do
    %{email: user.email, password: "#{user.password}MESSITALLUP"}
  end
end
