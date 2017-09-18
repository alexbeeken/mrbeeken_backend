defmodule MrbeekenBackend.GuardianSerializer do
  @moduledoc """
    This is used by guardian and, at the time of writing,
    I don't call any of these methods directly.
  """

  @behaviour Guardian.Serializer

  alias MrbeekenBackend.Repo
  alias MrbeekenBackendWeb.User

  def for_token(user = %User{}), do: { :ok, "User:#{user.id}" }
  def for_token(_), do: { :error, "Unknown resource type" }

  def from_token("User:" <> id), do: { :ok, Repo.get(User, String.to_integer(id)) }
  def from_token(_), do: { :error, "Unknown resource type" }
end
