defmodule Anagram do
  @doc """
  Returns all candidates that are anagrams of, but not equal to, 'base'.
  """
  @spec match(String.t, [String.t]) :: [String.t]
  def match(base, candidates) do
    candidate_signature = word_signature_list(candidates)
    base_signature = do_word_signature(base) |> String.to_atom
    matches = Keyword.get_values(candidate_signature,base_signature)
    matches
    |> Enum.filter(fn x ->
      String.downcase(base) != String.downcase(x) end)
  end

  @doc """
  Function takes a list of words and converts to a list of tuples
  i.e. a keyword map, in the form `[{signature, word}]`

  ## Example
  iex> Anagram.word_signature_list(["word","list","here"])
  [{:dorw,"word"},{:ilst,"list"},{:eehr,"here"}]
  """
  @spec word_signature_list([String.t]) :: [{String.t, String.t}]
  def word_signature_list(words) when is_list(words) do
    words
    |> Enum.map(&word_signature(&1))
  end

  @doc """
  Takes a word and returns a signature atom, along with the initial
  word passed in the format `{:signature,word}`
  """
  @spec word_signature(String.t) :: {String.t, String.t}
  def word_signature(word) when is_binary(word) do
    signature_atom =
      word
      |> do_word_signature
      |> String.to_atom
    {signature_atom, word}
  end

  @doc """
  For a word, it produces the signature for that word. The signature
   is the alphabetic order of the letters in the word, in lower case

  ## Examples
  iex> Anagram.do_word_signature("foobar")
  abfoor

  iex> Anagram.do_word_signature("Banana")
  aaabnn
  """
  def do_word_signature(word) do
    word
    |> String.downcase
    |> String.split("")
    |> Enum.sort
    |> tl
    |> Enum.join("")
  end
end
