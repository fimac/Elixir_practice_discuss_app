defmodule Discuss.TopicController do
  use Discuss.Web, :controller #imports all the functionality to our controller from web.ex file.

  alias Discuss.Topic

  def index(conn, _params) do
    topics = Repo.all(Topic)
    render conn, "index.html", topics: topics
  end

  def new(conn, _params) do
    changeset = Topic.changeset(%Topic{}, %{})
    render conn, "new.html", changeset: changeset
  end

# the params argument, receives the data from the form. Using pattern matching, we can store the topic in a variable topic.
  def create(conn, %{"topic" => topic}) do
    changeset = Topic.changeset(%Topic{}, topic)

    case Repo.insert(changeset) do
      {:ok, _topic} ->
        conn
        # flash message after post submitted
        |> put_flash(:info, "Topic Created")
        # redirect user to topics index /
        |> redirect(to: topic_path(conn, :index))

      {:error, changeset} ->
        render conn, "new.html", changeset: changeset
    end
  end

  def edit(conn, %{"id" => topic_id}) do
    # pull topic from db, Repo.get takes two arguments, the type, and the id of the record that we're trying to retrieve
    topic = Repo.get(Topic, topic_id)
    # create a changeset out of that topic
    changeset = Topic.changeset(topic)
    # form helpers are all expecting to be dealing with a changeset
    render conn, "edit.html", changeset: changeset, topic: topic
  end

  def update(conn, %{"id" => topic_id, "topic" => topic}) do
    # this is grabbing the old recortd from the db
    old_topic = Repo.get(Topic, topic_id)

    # this is getting the new attributes and passing to the changeset
    # changeset = Topic.changeset(old_topic, topic)
    changeset = Topic.changeset(old_topic, topic)

    case Repo.update(changeset) do
      {:ok, _topic} ->
        conn
        |> put_flash(:info, "Topic Updated")
        |> redirect(to: topic_path(conn, :index))
      {:error, changeset} ->
        render conn, "edit.html", changeset: changeset, topic: old_topic
    end
  end

  def delete(conn, %{"id" => topic_id}) do
    Repo.get!(Topic, topic_id) |> Repo.delete!

    conn
    |> put_flash(:info, "Topic Deleted")
    |> redirect(to: topic_path(conn, :index))

  end

end
