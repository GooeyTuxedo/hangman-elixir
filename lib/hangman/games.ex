# lib/hangman/games.ex
defmodule Hangman.Games do
  @moduledoc """
  The Games context.
  """

  alias Hangman.Game

  @doc """
  Creates a new game.
  """
  def new_game do
    Game.new_game()
  end

  @doc """
  Makes a guess in the game.
  """
  def make_guess(game, letter) do
    Game.make_guess(game, letter)
  end

  @doc """
  Gets the current state of the word with guessed letters revealed.
  """
  def revealed_word(game) do
    Game.revealed_word(game)
  end
end
