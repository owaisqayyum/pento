defmodule PentoWeb.WrongLive do
  use PentoWeb, :live_view

  def mount(_session, _param, socket) do
    {:ok, assign(socket, score: 0, right_answer: 4, message: "Guess a Number:", time: time())}
  end

  def handle_event("guess", %{"number" => guess} = data, socket) do
    right_answer =
      socket.assigns.right_answer
      |> to_string

    {message, score} =
      if guess == right_answer do
        message = "your guess: #{guess} is right. Congrats."
        score = socket.assigns.score + 1
        {message, score}
      else
        message = "your guess: #{guess} is wrong. Kindly guess again. "
        score = socket.assigns.score - 1
        {message, score}
      end

    time = time()
    {:noreply, assign(socket, message: message, score: score, time: time())}
  end

  def handle_event("restart", socket) do
    score = socket.assigns.score * 0
    {:noreply, score: score}
  end

  def render(assigns) do
    IO.inspect(assigns, label: :assigns)

    ~L"""
    <h1>Your score: <%= @score %></h1>
    <h2>
    <%= @message %>
    its <%= @time%>
    </h2>
    <h2>
    <%= for n <- 1..10 do %>
    <a href="#" phx-click="guess" phx-value-number="<%= n %>"><%= n %></a>
    <% end %>
    </h2>

    <button phx-click="restart">Restrat Game</button>
    """
  end

  def time() do
    DateTime.utc_now() |> to_string
  end
end
