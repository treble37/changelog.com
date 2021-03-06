defmodule Changelog.EpisodeGuest do
  use Changelog.Web, :model

  schema "episode_guests" do
    field :position, :integer
    field :delete, :boolean, virtual: true

    belongs_to :person, Changelog.Person
    belongs_to :episode, Changelog.Episode

    timestamps()
  end

  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, ~w(position episode_id person_id delete))
    |> validate_required([:position])
    |> mark_for_deletion()
  end

  def by_position do
    from p in __MODULE__, order_by: p.position
  end

  defp mark_for_deletion(changeset) do
    if get_change(changeset, :delete) do
      %{changeset | action: :delete}
    else
      changeset
    end
  end
end
