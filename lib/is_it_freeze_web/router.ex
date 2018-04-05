defmodule IsItFreezeWeb.Router do
  use IsItFreezeWeb, :router

  pipeline :browser do
    plug(:accepts, ["html"])
    plug(:fetch_session)
    plug(:fetch_flash)
    plug(:protect_from_forgery)
    plug(:put_secure_browser_headers)
  end

  pipeline :api do
    plug(:accepts, ["json"])
  end

  scope "/", IsItFreezeWeb do
    pipe_through(:api)

    get("/:year/:month/:day", FreezeController, :is_frozen)
  end
end
