defmodule Hangman.GameTest do
  use ExUnit.Case
  alias Hangman.Game

  test "new game returns the correct structure" do
    game = Game.new_game("phoenix")

    assert game.turns_left == 6
    assert game.game_state == :initializing
    assert game.word == "phoenix"
    assert MapSet.size(game.letters_guessed) == 0
  end

  test "new game without a word randomly picks a word" do
    game = Game.new_game()
    assert game.word != nil
    assert String.length(game.word) > 0
  end

  test "guessing a correct letter doesn't reduce turns" do
    game = Game.new_game("elixir")
    game = Game.make_guess(game, "e")

    assert game.turns_left == 6
    assert MapSet.member?(game.letters_guessed, "e")
    assert game.game_state != :lost
  end

  test "guessing an incorrect letter reduces turns" do
    game = Game.new_game("phoenix")
    game = Game.make_guess(game, "z")

    assert game.turns_left == 5
    assert MapSet.member?(game.letters_guessed, "z")
  end

  test "guessing a letter already guessed doesn't change turns" do
    game = Game.new_game("elixir")
    game = Game.make_guess(game, "e")
    turns_before = game.turns_left
    game = Game.make_guess(game, "e")

    assert game.turns_left == turns_before
    assert game.game_state == :already_guessed
  end

  test "revealed word shows correct guesses and underscores" do
    game = Game.new_game("elixir")
    game = Game.make_guess(game, "e")
    game = Game.make_guess(game, "i")

    assert Game.revealed_word(game) == "e _ i _ i _"
  end

  test "player can win the game" do
    game = Game.new_game("cat")
    game = Game.make_guess(game, "c")
    game = Game.make_guess(game, "a")
    game = Game.make_guess(game, "t")

    assert game.game_state == :won
  end

  test "player can lose the game" do
    game = Game.new_game("phoenix")
    game = Game.make_guess(game, "z")
    game = Game.make_guess(game, "y")
    game = Game.make_guess(game, "q")
    game = Game.make_guess(game, "m")
    game = Game.make_guess(game, "w")
    game = Game.make_guess(game, "v")

    assert game.game_state == :lost
  end

  test "no more guesses allowed after game is won" do
    game = Game.new_game("cat")
    game = Game.make_guess(game, "c")
    game = Game.make_guess(game, "a")
    game = Game.make_guess(game, "t")

    # Game is now won
    assert game.game_state == :won

    # Try another guess
    game_after = Game.make_guess(game, "x")

    # State should be unchanged
    assert game_after == game
  end

  test "no more guesses allowed after game is lost" do
    game = Game.new_game("cat")
    game = Game.make_guess(game, "z")
    game = Game.make_guess(game, "y")
    game = Game.make_guess(game, "w")
    game = Game.make_guess(game, "q")
    game = Game.make_guess(game, "m")
    game = Game.make_guess(game, "n")

    # Game is now lost
    assert game.game_state == :lost

    # Try another guess
    game_after = Game.make_guess(game, "x")

    # State should be unchanged
    assert game_after == game
  end
end
