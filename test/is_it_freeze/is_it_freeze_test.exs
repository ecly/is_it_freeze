defmodule IsItFreezeTest do
  use ExCheck
  use ExUnit.Case, async: true
  alias ExCheck.Sample
  alias IsItFreeze

  @some_date ~D[2000-01-01]

  @doc """
  Since excheck has no Date generators, we generate them
  using ints, adding integer offsets to some date.
  """
  def date_from_int(i) do
    Date.add(@some_date, i)
  end

  # Utility, check whether an int will be transformed to
  # a date that is either Saturday or Sunday.
  def is_weekend?(offset) do
    date = date_from_int(offset)
    Date.day_of_week(date) in 6..7
  end

  # Utility, check whether an int will be transformed to
  # a date that is among the last 2 days of its month
  def is_last_2_days?(offset) do
    date = date_from_int(offset)
    days_in_month = Date.days_in_month(date)
    {_year, _month, day} = Date.to_erl(date)
    days_in_month - day < 2
  end

  # Utility, check whether an int will be transformed to
  # a date that is among the first 3 days of its month
  def is_first_3_days?(offset) do
    date = date_from_int(offset)
    {_year, _month, day} = Date.to_erl(date)
    day <= 3
  end

  property :weekend_frozen do
    for_all x in such_that(xx in int() when is_weekend?(xx)) do
      date = date_from_int(x)
      IsItFreeze.frozen?(date)
    end
  end

  property :first_3_days_in_month_frozen do
    for_all x in such_that(xx in int() when is_first_3_days?(xx)) do
      date = date_from_int(x)
      IsItFreeze.frozen?(date)
    end
  end

  property :last_2_days_in_month_frozen do
    for_all x in such_that(xx in int() when is_last_2_days?(xx)) do
      date = date_from_int(x)
      IsItFreeze.frozen?(date)
    end
  end
end
