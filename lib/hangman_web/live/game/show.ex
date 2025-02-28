defmodule HangmanWeb.GameLive.Show do
  use HangmanWeb, :live_view

  alias Hangman.Games

  @impl true
  def mount(_params, _session, socket) do
    game = Games.new_game()

    socket =
      socket
      |> assign(:page_title, "Hangman Game")
      |> assign(:game, game)
      |> assign(:guess, "")

    {:ok, socket}
  end

  @impl true
  def handle_event("guess", %{"guess" => guess}, socket) when byte_size(guess) == 1 do
    current_game = socket.assigns.game
    game = Games.make_guess(current_game, guess)

    # Determine if the guess was correct
    is_correct = String.contains?(current_game.word, guess)

    # Check if the game just ended with this guess
    just_ended = game.game_state in [:won, :lost] && current_game.game_state not in [:won, :lost]

    socket =
      socket
      |> assign(:game, game)
      |> assign(:guess, "")

    # Push guess result event for sound effect
    if just_ended do
      # Push game-over event with win/lose status
      push_event(socket, "game-over", %{won: game.game_state == :won})
    else
      # Only push guess-result for non-ending guesses
      push_event(socket, "guess-result", %{correct: is_correct})
    end

    {:noreply, socket}
  end

  def handle_event("guess", _params, socket) do
    {:noreply, socket}
  end

  def handle_event("new_game", _params, socket) do
    game = Games.new_game()

    socket =
      socket
      |> assign(:game, game)
      |> assign(:guess, "")

    {:noreply, socket}
  end
end
