defmodule RemoteWeb.UserController do
  use RemoteWeb, :controller
  use GenServer

  alias Remote.Server

  def index(conn, _params) do
    pid = GenServer.whereis(Server)
    %{users: users, timestamp: timestamp} = Server.get_users(pid)

    render(conn, "index.json", users: users, timestamp: timestamp)
  end
end
