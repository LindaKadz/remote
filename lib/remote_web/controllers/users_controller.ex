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
        conn
        |> put_status(:not_found)
        |> put_view(RemoteWeb.ErrorView)
        |> render(:"500")
    end
  end
end
