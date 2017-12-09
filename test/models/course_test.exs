defmodule MrbeekenBackendWeb.CourseTest do
  use MrbeekenBackend.DataCase

  alias MrbeekenBackendWeb.Course

  @valid_attrs %{
    title: "Music Literacy 1",
    summary: "You'll learn note names and basic rhythms!"
  }
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = Course.changeset(%Course{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Course.changeset(%Course{}, @invalid_attrs)
    refute changeset.valid?
  end
end
