defmodule IsItFreeze.Easter do
  @moduledoc """
  Module for determining what date easter falls
  for a given year.
  """

  @doc """
  Returns an error tuple with the date of easter for the given year.
  Converted from this mess https://www.codeproject.com/Tips/1168636/When-Is-Easter
  """
  def date_of_easter(year) do
    goldenNumber = Integer.mod(year, 19)
    century = Integer.floor_div(year, 100)
    daysToNextFullMoon = Integer.mod(century - Integer.floor_div(century, 4) - Integer.floor_div(8 * century + 13, 25) + 19 * goldenNumber + 15, 30)
    daysToEquinox = daysToNextFullMoon - Integer.floor_div(daysToNextFullMoon, 28)
     * (1 - Integer.floor_div(daysToNextFullMoon, 28) * Integer.floor_div(29, daysToNextFullMoon + 1) * Integer.floor_div(21 - goldenNumber, 11))
    day = daysToEquinox - Integer.mod(year + Integer.floor_div(year, 4) + daysToEquinox + 2 - century + Integer.floor_div(century, 4), 7) + 28

    month = if day > 31, do: 4, else: 3
    day = if day > 31, do: day-31, else: day

    Date.new(year, month, day)
  end
end
