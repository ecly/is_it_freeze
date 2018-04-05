defmodule IsItFreeze do
  @moduledoc """
  IsItFreeze keeps the contexts that define your domain
  and business logic.

  Contexts are also responsible for managing your data, regardless
  if it comes from the database, an external API or others.
  """
  alias IsItFreeze.BankHolidays

  @doc """
  Returns a boolean indicating whether the given date
  is a freeze day or not.
  """
  def frozen?(date) do
    is_january_freeze?(date)
    || is_last_days_in_month_freeze?(date)
    || is_first_days_in_month_freeze?(date)
  end

  # TODO - we don't actually freeze entirety
  # january, so this can be more loose
  # when we know the exact rules
  defp is_january_freeze?(date) do
    {_year, month, _day} = Date.to_erl(date)
    month == 1
  end

  defp is_last_days_in_month_freeze?(date) do
    date
    |> last_date_in_month()
    |> Date.range(date)
    |> Enum.count(&is_bank_working_day?/1)
    |> :erlang.<(4)
  end

  defp is_first_days_in_month_freeze?(date) do
    date
    |> first_date_in_month()
    |> Date.range(date)
    |> Enum.count(&is_bank_working_day?/1)
    |> :erlang.<(3)
  end

  defp last_date_in_month(date) do
    days_in_month = Date.days_in_month(date)
    {year, month, _day} = Date.to_erl(date)
    {:ok, last_date} = Date.new(year, month, days_in_month)
    last_date
  end

  defp first_date_in_month(date) do
    {year, month, _day} = Date.to_erl(date)
    {:ok, first_date} = Date.new(year, month, 1)
    first_date
  end

  defp is_weekend?(date) do
    Date.day_of_week(date) in 6..7
  end

  defp is_bank_working_day?(date) do
    !is_weekend?(date) && !BankHolidays.is_bank_holiday?(date)
  end
end
