defmodule IsItFreeze do
  @moduledoc """
  IsItFreeze keeps the contexts that define your domain
  and business logic.

  Contexts are also responsible for managing your data, regardless
  if it comes from the database, an external API or others.
  """

  def is_weekend?(date) do
    Date.day_of_week(date) in 6..7
  end

  def is_last_2_days?(date) do
    days_in_month = Date.days_in_month(date)
    {_year, _month, day} = Date.to_erl(date)
    days_in_month - day < 2
  end

  def is_first_3_days?(date) do
    {_year, _month, day} = Date.to_erl(date)
    day <= 3
  end

  def is_bank_day?(date) do

  end

  def frozen?(date) do
    is_weekend?(date)
    || is_last_2_days?(date)
    || is_first_3_days?(date)
  end
end
