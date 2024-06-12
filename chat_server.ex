defmodule ChatServer.Application do
  use Application

  def start(_type, _args) do
    children = [
      {ChatServer.Repo, []},
      {ChatServer.Endpoint, []},
      {ChatServer.Presence, []},
    ]

    opts = [strategy: :one_for_one, name: ChatServer.Supervisor]
    Supervisor.start_link(children, opts)
  end
end

defmodule ChatServer.Endpoint do
  use Phoenix.Endpoint, otp_app: :chat_server

  socket "/socket", ChatServer.UserSocket,
    websocket: true,
    longpoll: false

  plug Plug.Parsers,
    parsers: [:urlencoded, :multipart, :json],
    pass: ["*/*"],
    json_decoder: Phoenix.json_library()

  plug Plug.MethodOverride
  plug Plug.Head
  plug Plug.Session, store: :ets, key: "_chat_server_key", signing_salt: "abcdefgh"
  plug ChatServer.Router
end

defmodule ChatServer.UserSocket do
  use Phoenix.Socket

  channel "room:*", ChatServer.RoomChannel

  def connect(%{"token" => token}, socket, _connect_info) do
    case ChatServer.Auth.authenticate(token) do
      {:ok, user_id} ->
        {:ok, assign(socket, :user_id, user_id)}
      {:error, reason} ->
        :error
    end
  end

  def id(socket), do: "user_socket:#{socket.assigns.user_id}"
end

defmodule ChatServer.RoomChannel do
  use Phoenix.Channel
  alias ChatServer.Presence

  def join("room:" <> room_id, _params, socket) do
    send(self(), :after_join)
    {:ok, assign(socket, :room_id, room_id)}
  end

  def handle_info(:after_join, socket) do
    {:ok, _} = Presence.track(socket, socket.assigns.user_id, %{
      online_at: inspect(System.system_time(:second))
    })
    push(socket, "presence_state", Presence.list(socket))
    {:noreply, socket}
  end

  def handle_in("new_msg", %{"body" => body}, socket) do
    broadcast!(socket, "new_msg", %{body: body})
    {:noreply, socket}
  end

  def terminate(_reason, socket) do
    {:ok, _} = Presence.untrack(socket, socket.assigns.user_id)
    {:noreply, socket}
  end
end

defmodule ChatServer.Auth do
  def authenticate(token) do
    # Perform token-based authentication logic here
    # Return {:ok, user_id} if authentication is successful, otherwise return {:error, reason}
    {:ok, 123}
  end
end
