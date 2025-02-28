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
    game = Games.make_guess(socket.assigns.game, guess)

    socket =
      socket
      |> assign(:game, game)
      |> assign(:guess, "")

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
