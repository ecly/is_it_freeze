defmodule IsItFreezeWeb.FreezeController do
  use IsItFreezeWeb, :controller
  alias IsItFreeze

  @doc """
  The sole controller of IsItFreeze,
  as the IsItFreeze application, does only a single thing.
  """
  def is_frozen(conn, %{"year" => y, "month" => m, "day" => d}) do
    year = String.to_integer(y)
    month = String.to_integer(m)
    day = String.to_integer(d)
    date_tuple = Date.new(year, month, day)
    case date_tuple do
      {:ok, date} ->
        frozen_val = IsItFreeze.frozen?(date)
        json(conn, frozen_val)
      _otherwise ->
        render(conn, IsItFreezeWeb.ErrorView, "error.json", %{error: "Bad date"})
    end
  end
end
