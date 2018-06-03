defmodule PigLatin do
  @vowels ["a", "e", "i", "o", "u"]
  @consonants ["b", "c", "d", "f", "g", "h", "j", "k", "l", "m", "n", "p", "q", "r", "s", "t", "v", "x", "y", "z"]
  @doc """
  Given a `phrase`, translate it a word at a time to Pig Latin.

  Words beginning with consonants should have the consonant moved to the end of
  the word, followed by "ay".

  Words beginning with vowels (aeiou) should have "ay" added to the end of the
  word.

  Some groups of letters are treated like consonants, including "ch", "qu",
  "squ", "th", "thr", and "sch".

  Some groups are treated like vowels, including "yt" and "xr".
  """
  @spec translate(phrase :: String.t()) :: String.t()
  def translate(phrase) do
    String.split(phrase, " ")
    |> Enum.map(&String.codepoints/1)
    |> Enum.map(&translater/1)
    |> Enum.join(" ")
  end

  def translater([head | tail]) when head in @vowels, do: [head | tail ++ "ay"]
  def translater(["q", "u" | tail]), do: tail ++ "quay"
  def translater(["q" | tail]), do: tail ++ "qay"
  def translater(["x", c | tail]) when c in ["r", "b"], do: ["x", c | tail ++ "ay"]
  def translater(["t", "h", "r" | tail]), do: tail ++ "thray"
  def translater(["y", c | tail]) when c in @consonants, do: ["y", c | tail ++ "ay"]
  def translater([c, "q", "u" | tail]) when c in @consonants, do: tail ++ c <> "quay"
  def translater(word) do
    chunks = Enum.split_while(word, fn c -> c in @consonants end)
    elem(chunks, 1) ++ elem(chunks, 0) ++ "ay"
  end

end
