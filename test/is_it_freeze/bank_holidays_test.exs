defmodule IsItFreeze.BankHolidaysTest do
  use ExCheck
  use ExUnit.Case, async: true
  alias IsItFreeze.BankHolidays

  property :christmas_eve do
    for_all year in pos_integer() do
      {:ok, date} = Date.new(year, 12, 24)
      BankHolidays.is_bank_holiday?(date)
    end
  end

  property :constitution_day do
    for_all year in pos_integer() do
      {:ok, date} = Date.new(year, 6, 5)
      BankHolidays.is_bank_holiday?(date)
    end
  end

  property :christmas_day do
    for_all year in pos_integer() do
      {:ok, date} = Date.new(year, 12, 25)
      BankHolidays.is_bank_holiday?(date)
    end
  end

  property :second_christmas_day do
    for_all year in pos_integer() do
      {:ok, date} = Date.new(year, 12, 26)
      BankHolidays.is_bank_holiday?(date)
    end
  end

  property :new_years_december do
    for_all year in pos_integer() do
      {:ok, date} = Date.new(year, 12, 31)
      BankHolidays.is_bank_holiday?(date)
    end
  end

  property :new_years_january do
    for_all year in pos_integer() do
      {:ok, date} = Date.new(year, 1, 1)
      BankHolidays.is_bank_holiday?(date)
    end
  end

  test "maundy thursday is bank holiday" do
    date = ~D[2018-03-29]
    assert BankHolidays.is_bank_holiday?(date)
  end

  test "good friday is bank holiday" do
    date = ~D[2018-03-30]
    assert BankHolidays.is_bank_holiday?(date)
  end

  test "easter day is bank holiday" do
    date = ~D[2018-04-01]
    assert BankHolidays.is_bank_holiday?(date)
  end

  test "second easter day is bank holiday" do
    date = ~D[2018-04-02]
    assert BankHolidays.is_bank_holiday?(date)
  end

  test "great prayer day is bank holiday" do
    date = ~D[2018-04-27]
    assert BankHolidays.is_bank_holiday?(date)
  end

  test "feast of the ascension is bank holiday" do
    date = ~D[2018-05-10]
    assert BankHolidays.is_bank_holiday?(date)
  end

  test "bank holiday is bank holiday" do
    date = ~D[2018-05-11]
    assert BankHolidays.is_bank_holiday?(date)
  end

  test "2nd pentecost day is bank holiday" do
    date = ~D[2018-05-21]
    assert BankHolidays.is_bank_holiday?(date)
  end
end
