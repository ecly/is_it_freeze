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
end
