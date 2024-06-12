# Real-time Chat Server

This is a real-time chat server implemented using Elixir and the Phoenix Framework. It allows users to send and receive messages instantly in chat rooms, handles user connections and disconnections, and maintains a list of active users.

## Features

- User Authentication: Simple token-based authentication to manage user identity.
- Multi-Room Chat: Users can create and join multiple chat rooms.
- Message Broadcasting: Utilizes Phoenix Channels for real-time broadcasting of messages to all connected clients in a particular room.
- Presence Tracking: Uses Phoenix Presence to keep track of who is online, joining, or leaving the chat room.
- Scalability: Leverages Elixir's ability to handle numerous simultaneous connections efficiently.

## Technical Components

- Elixir: The core application logic is written in Elixir.
- Phoenix Framework: Leverages Phoenix Channels for WebSocket communication and Phoenix Presence for presence tracking.
- ETS (Erlang Term Storage): Used to store chat history and user sessions temporarily.

## Getting Started

To run the chat server locally, follow these steps:

1. Make sure you have Elixir and Phoenix installed on your system.

2. Clone the repository:
   ```
   git clone https://github.com/your-username/real-time-chat-server.git
   ```

3. Navigate to the project directory:
   ```
   cd real-time-chat-server
   ```

4. Install the dependencies:
   ```
   mix deps.get
   ```

5. Set up the database:
   ```
   mix ecto.setup
   ```

6. Start the Phoenix server:
   ```
   mix phx.server
   ```

7. Open your web browser and visit `http://localhost:4000` to access the chat application.

## Configuration

- The chat server uses token-based authentication. Implement the authentication logic in the `ChatServer.Auth` module according to your requirements.

- Adjust the database configuration in `config/config.exs` to match your database settings.

## Contributing

Contributions are welcome! If you find any issues or have suggestions for improvements, please open an issue or submit a pull request.

## License

This project is licensed under the [MIT License](LICENSE).

## Acknowledgements

- [Elixir](https://elixir-lang.org/)
- [Phoenix Framework](https://phoenixframework.org/)
- [Phoenix Channels](https://hexdocs.pm/phoenix/channels.html)
- [Phoenix Presence](https://hexdocs.pm/phoenix/presence.html)
