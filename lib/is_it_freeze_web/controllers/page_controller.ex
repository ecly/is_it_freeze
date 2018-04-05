defmodule IsItFreezeWeb.PageController do
  use IsItFreezeWeb, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end
end
