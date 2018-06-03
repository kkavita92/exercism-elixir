defmodule RotationalCipher do
  @doc """
  Given a plaintext and amount to shift by, return a rotated string.

  Example:
  iex> RotationalCipher.rotate("Attack at dawn", 13)
  "Nggnpx ng qnja"
  """
  @spec rotate(text :: String.t(), shift :: integer) :: String.t()
  def rotate(text, shift) do
   text
   |> to_charlist()
   |> Enum.map(&shift(&1, shift))
   |> to_string()
 end

 defp shift(letter, shift) when letter in ?a..?z do
   shift(letter, shift, ?a)
 end

 defp shift(letter, shift) when letter in ?A..?Z do
   shift(letter, shift, ?A)
 end

 defp shift(letter, _), do: letter

 defp shift(letter, shift, lowerbound) do 
   lowerbound + rem(letter - lowerbound + shift, 26)
 end
end
