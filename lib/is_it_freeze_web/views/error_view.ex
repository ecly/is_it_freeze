defmodule IsItFreezeWeb.ErrorView do
  use IsItFreezeWeb, :view

  def render("error.json", %{error: error}) do
    error
  end

  def template_not_found(_template, assigns) do
    render("500.json", assigns)
  end
end
