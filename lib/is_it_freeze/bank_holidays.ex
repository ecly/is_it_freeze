defmodule IsItFreeze.BankHolidays do
  @moduledoc """
  Module for determining whether a given date
  is a bank holiday.
  """

  alias IsItFreeze.Easter

  @doc """
  Returns true if the given date is a bank holiday,
  otherwise returns false.
  """
  def is_bank_holiday?(date) do
    {year, _month, _day} = Date.to_erl(date)
    easter = Easter.date_of_easter(year)
    is_static_holiday?(date) || is_easter_holiday?(date)
  end

  defp is_static_holiday?(date) do
    {_year, month, day} = Date.to_erl(date)

    case {month, day} do
      # new year's day
      {1, 1} ->
        true

      # constitution day
      {6, 5} ->
        true

      # christmas eve
      {12, 24} ->
        true

      # christmas day
      {12, 25} ->
        true

      # 2nd christmas day
      {12, 26} ->
        true

      # new year's day
      {12, 31} ->
        true

      otherwise ->
        false
    end
  end

  # Mapping of offsets from easter,
  # to bank holidays
  @easter_holiday_offsets %{
    -3 => "Maundy Thursday",
    -2 => "Good Friday",
    0 => "Easter day",
    1 => "2nd Easter day",
    26 => "Great Prayer Day",
    39 => "Feast of the Ascension",
    40 => "Bank holiday",
    50 => "2nd Pentecost Day"
  }
  defp is_easter_holiday?(date) do
    {year, month, day} = Date.to_erl(date)
    {:ok, easter} = Easter.date_of_easter(year)
    offset = Date.diff(date, easter)
    easter_offsets = Map.keys(@easter_holiday_offsets)
    offset in easter_offsets
  end
end
