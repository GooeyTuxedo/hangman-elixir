defmodule Hangman.Game do
  defstruct [
    word: "",
    letters_guessed: MapSet.new(),
    turns_left: 6,
    game_state: :initializing
  ]

  def new_game(word) do
    %__MODULE__{
      word: String.downcase(word)
    }
  end

  def new_game do
    new_game(random_word())
  end

  def make_guess(game, guess) do
    guess = String.downcase(guess)

    cond do
      game.game_state in [:won, :lost] ->
        game
      MapSet.member?(game.letters_guessed, guess) ->
        Map.put(game, :game_state, :already_guessed)
      true ->
        game
        |> Map.put(:letters_guessed, MapSet.put(game.letters_guessed, guess))
        |> score_guess(guess)
        |> check_win_or_lose()
    end
  end

  defp score_guess(game, guess) do
    if String.contains?(game.word, guess) do
      game
    else
      Map.update!(game, :turns_left, &(&1 - 1))
    end
  end

  defp check_win_or_lose(game) do
    cond do
      game.turns_left <= 0 ->
        Map.put(game, :game_state, :lost)
      word_guessed?(game) ->
        Map.put(game, :game_state, :won)
      true ->
        Map.put(game, :game_state, :good_guess)
    end
  end

  defp word_guessed?(game) do
    word_letters = game.word |> String.codepoints() |> MapSet.new()
    MapSet.subset?(word_letters, game.letters_guessed)
  end

  def revealed_word(game) do
    game.word
    |> String.codepoints()
    |> Enum.map(fn letter ->
      if MapSet.member?(game.letters_guessed, letter) do
        letter
      else
        "_"
      end
    end)
    |> Enum.join(" ")
  end

  defp random_word do
    # You could read from a file or API, but for simplicity:
    words = ~w(phoenix elixir programming functional erlang beam)
    Enum.random(words)
  end
end
