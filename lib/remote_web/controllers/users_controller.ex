defmodule RemoteWeb.UserController do
  use RemoteWeb, :controller
  use GenServer

  alias Remote.Server

  def index(conn, _params) do
    pid = GenServer.whereis(Server)
    # %{users: users, timestamp: timestamp} = Server.get_users(pid)

    case Server.get_users(pid) do
      %{users: users, timestamp: timestamp} ->
        render(conn, "index.json", users: users, timestamp: timestamp)
      _ ->
        render(conn, "error.json")
    end
  end
end
