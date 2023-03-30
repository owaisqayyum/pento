defmodule PentoWeb.WrongLive do
    use PentoWeb, :live_view
    
    def mount(_params, _session, socket) do
        {:ok, assign(socket, score: 0, message: "Make a guess: ", correct: Enum.random(1..10))}
    end
    
   def render(assigns) do
    IO.inspect(assigns, label: "assigns")
        ~H"""
        <h1> Your Score is: <%= assigns.score %></h1>
        <h2> <%= assigns.message %></h2>
        <h2> 
            <%= for n <- 1..10 do %>
                <.link href="#" phx-click="guess" phx-value-number={n} >
                <%= n %>
                </.link>
            <% end %>
        </h2>
        """
    end 

    def handle_event("guess", %{"number" => number}, socket) do
        number = String.to_integer(number)

        {message, score} = 
            if number == socket.assigns.correct do
                {"Your guess: #{number}. Correct!", socket.assigns.score + 1} 
            else
                {"Your guess: #{number}. Wrong. Guess again. ", socket.assigns.score - 1}
            end

        {:noreply, assign(socket, score: score, message: message)}
        
        
    end
    
end