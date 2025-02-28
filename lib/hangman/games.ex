defmodule Hangman.Games do
  @moduledoc """
  The Games context.
  """

  alias Hangman.Game

  @doc """
  Creates a new game with the given difficulty.
  """
  def new_game(difficulty \\ :medium) when is_atom(difficulty) do
    Game.new_game_with_difficulty(difficulty)
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

  @doc """
  Returns a list of available difficulty levels.
  """
  def difficulty_levels do
    [:easy, :medium, :hard]
  end
end
