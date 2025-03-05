defmodule HangmanWeb.HealthController do
  use HangmanWeb, :controller

  def check(conn, _params) do
    # You can add more sophisticated checks here if needed
    # For example, check DB connection, Redis connection, etc.
    
    conn
    |> put_resp_content_type("application/json")
    |> send_resp(200, Jason.encode!(%{status: "ok"}))
  end
end