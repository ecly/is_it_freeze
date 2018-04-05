defmodule IsItFreezeWeb.FreezeController do
  @moduledoc """
  The sole controller of IsItFreeze,
  as the IsItFreeze application, only does a single thing.
  """

  use IsItFreezeWeb, :controller
  alias IsItFreeze

  @doc """
  Returns whether the given date is a freeze date.
  Renturns an error in case the given date, cannot be parsed.
  """
  def is_it_freeze(conn, %{"year" => y, "month" => m, "day" => d}) do
    year = String.to_integer(y)
    month = String.to_integer(m)
    day = String.to_integer(d)
    date_tuple = Date.new(year, month, day)
    case date_tuple do
      {:ok, date} ->
        frozen_val = IsItFreeze.frozen?(date)
        json(conn, frozen_val)
      _otherwise ->
        render(conn, IsItFreezeWeb.ErrorView, "error.json", %{error: "Bad date. Format is /year/month/day."})
    end
  end

  @doc """
  Returns whether today is a freeze date.
  """
  def is_it_freeze_today(conn, _params) do
    today = Date.utc_today()
    frozen_val = IsItFreeze.frozen?(today)
    json(conn, frozen_val)
  end
end
