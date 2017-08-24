defmodule Discuss.Topic do
  use Discuss.Web, :model

  schema "topics" do
    field :title, :string
  end

  def changeset(struct, params \\ %{}) do #\\ is how you add default arguments, so if params is empty
    struct
    |> cast(params, [:title])
    |> validate_required([:title])
  end
end
