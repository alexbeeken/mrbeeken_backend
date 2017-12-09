defmodule MrbeekenBackendWeb.UnitTest do
  use MrbeekenBackend.DataCase

  alias MrbeekenBackendWeb.Unit

  @valid_attrs %{
    title: "Note Names",
    summary: "You'll learn note names in this unit."
  }
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = Unit.changeset(%Unit{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Unit.changeset(%Unit{}, @invalid_attrs)
    refute changeset.valid?
  end
end
