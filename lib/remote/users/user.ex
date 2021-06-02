defmodule Remote.Users.User do
  use Ecto.Schema
  import Ecto.Changeset

  schema "users" do
    field :points, :integer

    timestamps()
  end

  def changeset(user, params \\ %{}) do
    user
    |> cast(params, [:points])
    |> validate_required(:points)
  end
end
