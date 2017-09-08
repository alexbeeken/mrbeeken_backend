defmodule MrbeekenBackendWeb.UsersControllerTest do
  use MrbeekenBackendWeb.ConnCase
  alias MrbeekenBackend.Repo
  alias MrbeekenBackendWeb.User
  alias MrbeekenBackendWeb.Session

  @request_attrs %{username: "test@example.com", password: "123456abc"}
  @user_attrs %{email: "test@example.com", password: "123456abc", password_confirmation: "123456abc"}
end
