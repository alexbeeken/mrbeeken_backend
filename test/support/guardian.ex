defmodule Guardian do
  def encode_and_sign(model) do
    {:ok, "Bearer 12345", nil}
  end

  def revoke(token) do
    if token == "Bearer 12345" do
      {:ok, nil}
    else
      {:error, nil}
    end
  end

  def decode_and_verify(token) do
    if token == "Bearer 12345" do
      {:ok, nil}
    else
      {:error, nil}
    end
  end
end
