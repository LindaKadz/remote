defmodule Remote.Server do
  @moduledoc """
   User context
  """
  use GenServer

  alias Remote.Users.UserContext

  def start_link(_opts \\ %{}) do
    GenServer.start_link(__MODULE__, %{max_number: random_number(), timestamp: nil}, name: __MODULE__)
  end

  def get_users(pid) do
    GenServer.call(pid, :max)
  end

  def init(state) do
    schedule_next_server_run()
    {:ok, state}
  end

  defp random_number do
    :rand.uniform(100)
  end

  defp schedule_next_server_run do
    Process.send_after(self(), :update, 60 * 1000)
  end

  def handle_info(:update, state) do
    update_points()
    schedule_next_server_run()

    new_state = Map.put(state, :max_number, random_number())
    {:noreply, new_state}
  end

  defp update_points do
    UserContext.list_users()
    |> Enum.each(fn user ->
      UserContext.update_user(user, %{points: random_number()})
    end)
  end

  def handle_call(:max, _from, %{max_number: max_number, timestamp: timestamp} = state) do
    users = UserContext.find_users_with_points_greater_than_max_number(max_number)
    new_state = Map.put(state, :timestamp, NaiveDateTime.local_now())
    reply = %{users: users, timestamp: timestamp}
    {:reply, reply, new_state, 1_000_000}
  end
end
