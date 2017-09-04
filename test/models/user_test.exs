defmodule MrbeekenBackendWeb.UserTest do
  use MrbeekenBackend.DataCase

  alias MrbeekenBackendWeb.User

  @valid_attrs %{email: "some email"}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = User.changeset(%User{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = User.changeset(%User{}, @invalid_attrs)
    refute changeset.valid?
  end
end
