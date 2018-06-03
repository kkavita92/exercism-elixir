defmodule ProteinTranslation do

  @codon_lookup %{
    "UGU" => "Cysteine",
    "UGC" => "Cysteine",
    "UUA" => "Leucine",
    "UUG" => "Leucine",
    "AUG" => "Methionine",
    "UUU" => "Phenylalanine",
    "UUC" => "Phenylalanine",
    "UCU" => "Serine",
    "UCC" => "Serine",
    "UCA" => "Serine",
    "UCG" => "Serine",
    "UGG" => "Tryptophan",
    "UAU" => "Tyrosine",
    "UAC" => "Tyrosine",
    "UAA" => "STOP",
    "UAG" => "STOP",
    "UGA" => "STOP"
  }

  @doc """
  Given an RNA string, return a list of proteins specified by codons, in order.
  """
  @spec of_rna(String.t()) :: {atom, list(String.t())}
  def of_rna(rna) do
    split_rna =
    String.codepoints(rna)
    |> Enum.chunk(3)
    |> Enum.map(&Enum.join/1)

    case map_rna(split_rna) do
      {list, ["invalid RNA"]} -> {:error, "invalid RNA"}
      {codon_list, list} -> {:ok, codon_list}
    end

  end

  def map_rna(rna_list) do
    Enum.flat_map_reduce(rna_list, [], fn(x, acc) ->
      case of_codon(x) do
        {:ok, "STOP"} -> {:halt, acc}
        {:ok, value} -> {[value], acc}
        {:error, msg} -> {:halt, ["invalid RNA"]}

      end
    end)

  end

  @spec of_codon(String.t()) :: {atom, String.t()}
  def of_codon(codon) do
    case Map.fetch(@codon_lookup, codon) do
      :error -> {:error, "invalid codon"}
      {:ok, value} -> {:ok, value}
    end
  end
end
