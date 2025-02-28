defmodule HangmanWeb.GameLive.Show do
  use HangmanWeb, :live_view

  alias Hangman.Games

  @impl true
  def mount(_params, _session, socket) do
    socket =
      socket
      |> assign(:page_title, "Hangman Game")
      |> assign(:game, nil)
      |> assign(:guess, "")
      |> assign(:last_guess, nil)
      |> assign(:last_guess_correct, nil)
      |> assign(:difficulty_levels, Games.difficulty_levels())
      |> assign(:screen, :difficulty_select)

    {:ok, socket}
  end

  @impl true
  def handle_event("select_difficulty", %{"difficulty" => difficulty}, socket) do
    difficulty = String.to_existing_atom(difficulty)
    game = Games.new_game(difficulty)

    socket =
      socket
      |> assign(:game, game)
      |> assign(:screen, :game)  # Switch to game screen

    {:noreply, socket}
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
      |> assign(:last_guess, guess)
      |> assign(:last_guess_correct, is_correct)

    # Event dispatching for sounds
    socket =
      if just_ended do
        push_event(socket, "game-over", %{won: game.game_state == :won})
      else
        push_event(socket, "guess-result", %{correct: is_correct})
      end

    # Add a timer to clear the animation state after 1 second
    Process.send_after(self(), :clear_animation, 1000)

    {:noreply, socket}
  end

  # Handle animation clearing
  @impl true
  def handle_info(:clear_animation, socket) do
    socket =
      socket
      |> assign(:last_guess, nil)
      |> assign(:last_guess_correct, nil)

    {:noreply, socket}
  end

  # Handle when user clicks a letter instead of typing
  @impl true
  def handle_event("guess", %{"guess" => guess}, socket) do
    {:noreply, socket}
  end

  @impl true
  def handle_event("new_game", _params, socket) do
    socket =
      socket
      |> assign(:screen, :difficulty_select)
      |> assign(:game, nil)
      |> assign(:guess, "")
      |> assign(:last_guess, nil)
      |> assign(:last_guess_correct, nil)

    {:noreply, socket}
  end
end
