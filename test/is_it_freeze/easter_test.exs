defmodule IsItFreeze.EasterTest do
  use ExUnit.Case, async: true
  alias IsItFreeze.Easter

  test "2016 easter" do
    easter = ~D[2016-03-27]
    {:ok, date} = Easter.date_of_easter(2016)
    assert easter == date
  end

  test "2017 easter" do
    easter = ~D[2017-04-16]
    {:ok, date} = Easter.date_of_easter(2017)
    assert easter == date
  end

  test "2018 easter" do
    easter = ~D[2018-04-01]
    {:ok, date} = Easter.date_of_easter(2018)
    assert easter == date
  end

  test "2019 easter" do
    easter = ~D[2019-04-21]
    {:ok, date} = Easter.date_of_easter(2019)
    assert easter == date
  end

  test "2020 easter" do
    easter = ~D[2020-04-12]
    {:ok, date} = Easter.date_of_easter(2020)
    assert easter == date
  end
end
