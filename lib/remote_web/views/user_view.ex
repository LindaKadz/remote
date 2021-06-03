defmodule RemoteWeb.UserView do
  use RemoteWeb, :view

  def render("index.json", %{users: users, timestamp: timestamp}) do
    %{users: Enum.map(users, &user_json/1), timestamp: timestamp}
  end

  def user_json(user) do
    %{id: user.id, points: user.points}
  end
end
