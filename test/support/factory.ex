defmodule MrbeekenBackendWeb.Factory do
  use ExMachina.Ecto, repo: MrbeekenBackend.Repo
  
  alias MrbeekenBackendWeb.User

  def user_factory do
    %User{
      email: sequence(:email, &"email-#{&1}@example.com"),
      password: "123456abc",
      password_confirmation: "123456abc",
      password_hash: Comeonin.Bcrypt.hashpwsalt("123456abc")
    }
  end
end
