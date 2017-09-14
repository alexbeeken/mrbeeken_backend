defmodule MrbeekenBackendWeb.TestCreds do
  alias MrbeekenBackendWeb.User

  @user_attrs %{email: "test@example.com", password: "123456abc", password_confirmation: "123456abc"}
  def user_attrs, do: @user_attrs

  def valid_login_params(user \\ %User{email: "test@example.com", password: "123456abc"}) do
    %{email: user.email, password: user.password}
  end

  def bad_password_login_params(user \\ %User{email: "test@example.com", password: "123456abc"}) do
    %{email: user.email, password: "#{user.password}MESSITALLUP"}
  end
end
