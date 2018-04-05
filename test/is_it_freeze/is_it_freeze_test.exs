defmodule IsItFreezeTest do
  use ExUnit.Case, async: true
  alias IsItFreeze

  test "it is freeze on weekends" do
    weekend = ~D[2018-07-04] # saturday
    weekend = ~D[2018-08-04] # saturday
    assert IsItFreeze.frozen?(weekend)
  end

  test "it is freeze on first 2 days in a month" do
    first = ~D[2018-01-01]
    second = ~D[2018-02-02]
    assert IsItFreeze.frozen?(first)
    assert IsItFreeze.frozen?(second)
  end

  test "it is freeze on last 2 days in a month" do
    last = ~D[2018-01-31]
    second_to_last = ~D[2018-02-27]
    third_to_last = ~D[2018-03-29]
    assert IsItFreeze.frozen?(last)
    assert IsItFreeze.frozen?(second_to_last)
    assert IsItFreeze.frozen?(third_to_last)
  end
end
