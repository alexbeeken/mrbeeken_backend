defmodule MrbeekenBackendWeb.Factory do
  @moduledoc """
    Used by ex machina to create test users.
    This was implemented to make unique users easier
    to generate on the fly and to simplify tests.
  """

  use ExMachina.Ecto, repo: MrbeekenBackend.Repo

  alias MrbeekenBackendWeb.{User, Post, Course, Unit}

  def user_factory do
    %User{
      email: sequence(:email, &"email-#{&1}@example.com"),
      password: "123456abc",
      password_confirmation: "123456abc",
      password_hash: Comeonin.Bcrypt.hashpwsalt("123456abc"),
      superuser: false
    }
  end

  def post_factory do
    %Post{
      title: sequence("post title"),
      summary: sequence("post summary"),
      content: sequence("post content"),
      thumbnail: sequence("http://www.google.com/"),
      audio: sequence("http://www.google.com/")
    }
  end

  def course_factory do
    %Course{
      title: sequence("course title"),
      summary: sequence("course summary")
    }
  end

  def unit_factory do
    %Unit{
      title: sequence("unit title"),
      summary: sequence("unit summary"),
      course: build(:course)
    }
  end
end
