defmodule IsItFreezeTest do
  use ExCheck
  use ExUnit.Case, async: true
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
  # a date that is among the last 3 days of its month
  def is_last_3_days?(offset) do
    date = date_from_int(offset)
    days_in_month = Date.days_in_month(date)
    {_year, _month, day} = Date.to_erl(date)
    days_in_month - day < 3
  end

  # Utility, check whether an int will be transformed to
  # a date that is among the first 2 days of its month
  def is_first_2_days?(offset) do
    date = date_from_int(offset)
    {_year, _month, day} = Date.to_erl(date)
    day <= 2
  end

  property :first_2_days_in_month_frozen do
    for_all x in such_that(xx in int() when is_first_2_days?(xx)) do
      date = date_from_int(x)
      IsItFreeze.frozen?(date)
    end
  end

  property :last_3_days_in_month_frozen do
    for_all x in such_that(xx in int() when is_last_3_days?(xx)) do
      date = date_from_int(x)
      IsItFreeze.frozen?(date)
    end
  end

  test "2018 first half non-frozen days spotchecking" do
    # january is temporarily entirely frozen
    # refute IsItFreeze.frozen?(~D[2018-01-25])
    refute IsItFreeze.frozen?(~D[2018-02-05])
    refute IsItFreeze.frozen?(~D[2018-02-09])
    refute IsItFreeze.frozen?(~D[2018-02-20])
    refute IsItFreeze.frozen?(~D[2018-02-23])
    refute IsItFreeze.frozen?(~D[2018-03-05])
    refute IsItFreeze.frozen?(~D[2018-03-13])
    refute IsItFreeze.frozen?(~D[2018-03-15])
    refute IsItFreeze.frozen?(~D[2018-03-23])
    refute IsItFreeze.frozen?(~D[2018-04-06])
    refute IsItFreeze.frozen?(~D[2018-04-09])
    refute IsItFreeze.frozen?(~D[2018-04-16])
    refute IsItFreeze.frozen?(~D[2018-04-17])
    refute IsItFreeze.frozen?(~D[2018-04-23])
    refute IsItFreeze.frozen?(~D[2018-04-24])
    refute IsItFreeze.frozen?(~D[2018-05-03])
    refute IsItFreeze.frozen?(~D[2018-05-04])
    refute IsItFreeze.frozen?(~D[2018-05-15])
    refute IsItFreeze.frozen?(~D[2018-05-22])
    refute IsItFreeze.frozen?(~D[2018-05-25])
    refute IsItFreeze.frozen?(~D[2018-05-28])
    refute IsItFreeze.frozen?(~D[2018-05-28])
    refute IsItFreeze.frozen?(~D[2018-06-06])
    refute IsItFreeze.frozen?(~D[2018-06-11])
    refute IsItFreeze.frozen?(~D[2018-06-15])
    refute IsItFreeze.frozen?(~D[2018-06-25])
    refute IsItFreeze.frozen?(~D[2018-06-26])
  end

  test "2018 first half frozen days complete" do
    # freeze period 1
    assert IsItFreeze.frozen?(~D[2018-01-29])
    assert IsItFreeze.frozen?(~D[2018-01-30])
    assert IsItFreeze.frozen?(~D[2018-01-31])
    assert IsItFreeze.frozen?(~D[2018-02-01])
    assert IsItFreeze.frozen?(~D[2018-02-02])

    # freeze period 2
    assert IsItFreeze.frozen?(~D[2018-02-26])
    assert IsItFreeze.frozen?(~D[2018-02-27])
    assert IsItFreeze.frozen?(~D[2018-02-28])
    assert IsItFreeze.frozen?(~D[2018-03-01])
    assert IsItFreeze.frozen?(~D[2018-03-02])

    # freeze period 3
    assert IsItFreeze.frozen?(~D[2018-03-26])
    assert IsItFreeze.frozen?(~D[2018-03-27])
    assert IsItFreeze.frozen?(~D[2018-03-28])
    assert IsItFreeze.frozen?(~D[2018-03-29])
    assert IsItFreeze.frozen?(~D[2018-03-30])
    assert IsItFreeze.frozen?(~D[2018-03-31])
    assert IsItFreeze.frozen?(~D[2018-04-01])
    assert IsItFreeze.frozen?(~D[2018-04-02])
    assert IsItFreeze.frozen?(~D[2018-04-03])
    assert IsItFreeze.frozen?(~D[2018-04-04])

    # freeze period 4
    assert IsItFreeze.frozen?(~D[2018-04-25])
    assert IsItFreeze.frozen?(~D[2018-04-26])
    assert IsItFreeze.frozen?(~D[2018-04-27])
    assert IsItFreeze.frozen?(~D[2018-04-28])
    assert IsItFreeze.frozen?(~D[2018-04-29])
    assert IsItFreeze.frozen?(~D[2018-04-30])
    assert IsItFreeze.frozen?(~D[2018-05-01])
    assert IsItFreeze.frozen?(~D[2018-05-02])

    # freeze period 5
    assert IsItFreeze.frozen?(~D[2018-05-29])
    assert IsItFreeze.frozen?(~D[2018-05-30])
    assert IsItFreeze.frozen?(~D[2018-05-31])
    assert IsItFreeze.frozen?(~D[2018-06-01])
    assert IsItFreeze.frozen?(~D[2018-06-02])
    assert IsItFreeze.frozen?(~D[2018-06-03])

    # freeze period 6 (june half)
    assert IsItFreeze.frozen?(~D[2018-06-27])
    assert IsItFreeze.frozen?(~D[2018-06-28])
    assert IsItFreeze.frozen?(~D[2018-06-29])
    assert IsItFreeze.frozen?(~D[2018-06-30])
  end
end
