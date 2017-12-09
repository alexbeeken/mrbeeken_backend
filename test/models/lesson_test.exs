defmodule MrbeekenBackendWeb.LessonTest do
  use MrbeekenBackend.DataCase

  alias MrbeekenBackendWeb.Lesson

  @valid_attrs %{
    title: "Note Names",
    content: "The lesson is this",
    unit_id: 0
  }
  @no_unit_attrs %{
    title: "Note Names",
    content: "The lesson is this"
  }
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = Lesson.changeset(%Lesson{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Lesson.changeset(%Lesson{}, @invalid_attrs)
    refute changeset.valid?
  end

  test "changeset without unit association" do
    changeset = Lesson.changeset(%Lesson{}, @no_unit_attrs)
    refute changeset.valid?
  end
end
