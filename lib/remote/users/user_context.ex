defmodule Remote.Users.UserContext do
   @moduledoc """
    User context
  """

  alias Remote.Users.User
  alias Remote.Repo

  import Ecto.Query, only: [from: 2]

  def create_user(params) do
    %User{}
    |> User.changeset(params)
    |> Repo.insert()
  end

  def update_user(%User{} = user, params) do
    user
    |> User.changeset(params)
    |> Repo.update()
  end

  def list_users do
    Repo.all(User, timeout: 1_000_000)
  end
end
