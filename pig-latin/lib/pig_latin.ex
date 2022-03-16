defmodule PigLatin do
  @doc """
  Given a `phrase`, translate it a word at a time to Pig Latin.
  """

  @vowel ["a", "e", "i", "o", "u"]
  @ay ["a", "y"]

  @spec translate(phrase :: String.t()) :: String.t()
  def translate(phrase) do
    phrase
    |> String.downcase()
    |> String.graphemes()
    |> check_rules()
    |> List.to_string()
  end

  defp check_rules(["x" | ["r" | _t]] = phrase) do
    phrase ++ @ay
  end

  defp check_rules(["y" | ["t" | _t]] = phrase) do
    phrase ++ @ay
  end

  defp check_rules([h | _t] = phrase) when h in @vowel do
    phrase ++ @ay
  end

  defp check_rules([h | [b | ["y" | t]]]) when h not in @vowel and b not in @vowel do
    ["y"] ++ t ++ [h, b] ++ @ay
  end

  defp check_rules([h | ["q" | ["u" | t]]]) when h not in @vowel do
    t ++ [h, "q", "u"] ++ @ay
  end

  defp check_rules([h | ["y"]]) do
    ["y", h] ++ @ay
  end

  defp check_rules([h | t]) when h not in @vowel do
    check_rules(t ++ [h])
  end

  defp check_rules(phrase) do
    phrase ++ @ay
  end
end
