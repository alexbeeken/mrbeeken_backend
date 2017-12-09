defmodule MrbeekenBackendWeb.AssessmentTest do
  use MrbeekenBackend.DataCase

  alias MrbeekenBackendWeb.Assessment

  @valid_attrs %{
    title: "Note Names",
    unit_id: 0
  }
  @no_unit_attrs %{
    title: "Note Names"
  }
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = Assessment.changeset(%Assessment{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Assessment.changeset(%Assessment{}, @invalid_attrs)
    refute changeset.valid?
  end

  test "changeset without unit association" do
    changeset = Assessment.changeset(%Assessment{}, @invalid_attrs)
    refute changeset.valid?
  end
end
