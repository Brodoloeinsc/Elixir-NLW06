defmodule Wabanex.Users.Get do
  # params |> User.changeset() |> Repo.insert()
  alias Ecto.UUID
  alias Wabanex.{User, Repo}

  def call(id) do
    id
    |> UUID.cast()
    |> handle_response()
  end

  defp handle_response(:error) do
    {:error, "invalid UUID"}
  end

  defp handle_response({:ok, uuid}) do
    case Repo.get(User, uuid) do
      nil -> {:error, "User not found"}
      user -> {:ok, user}
    end
  end
end
