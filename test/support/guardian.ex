defmodule Guardian do
  def encode_and_sign(model) do
    {:ok, "12345", nil}
  end

  def revoke(token) do
    if token == "12345" do
      {:ok, nil}
    else
      {:error, nil}
    end
  end
end
