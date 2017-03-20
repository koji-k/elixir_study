defmodule ElixirStudyTest do
  use ExUnit.Case
  doctest ElixirStudy

  test "the truth" do
    assert 1 + 1 == 2
  end

  #  test "sample" do
  #  assert [2, 4, 6, 8, 10] == 1..5
  #  |> Enum.map(&(&1 * 2))
  #end
end
