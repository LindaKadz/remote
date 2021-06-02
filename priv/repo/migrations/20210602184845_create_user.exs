defmodule Remote.Repo.Migrations.CreateUser do
  use Ecto.Migration

  def change do
    create_table(:users) do
      add :points, :integer

      timestamps()
    end
  end
end
