defmodule Discuss.Router do
  use Discuss.Web, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", Discuss do
    pipe_through :browser # Use the default browser stack

    # get "/", TopicController, :index
    # get "/topics/new", TopicController, :new
    # post "/topics", TopicController, :create
    # get "/topics/:id/edit", TopicController, :edit
    # put "/topics/:id", TopicController, :update

    # When ever someone makes any type of request following our RESTful conventions, we will assume that the topic controller is set up correctly, and forward the user on to the right page.
    resources "/", TopicController

  end

  # Other scopes may use custom stacks.
  # scope "/api", Discuss do
  #   pipe_through :api
  # end
end
