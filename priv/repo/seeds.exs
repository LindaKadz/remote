# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     Remote.Repo.insert!(%Remote.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.

alias Remote.Repo
alias Remote.Users.User
alias Remote.Users.UserContext

Repo.delete_all(User)

Enum.each(0..1000000, fn(_) ->
  UserContext.create_user(%{points: 0})
end)
