defmodule Functions do
  @module """
  関数の使い方
  """
  use ExUnit.Case
  doctest ElixirStudy

  test "base" do
    defmodule Hoge do
      def f1(:ok, x) do
        ~s(ok - #{x})
      end
      def f1(:ng, x) do
        ~s(ng - #{x})
      end
    end

  assert Hoge.f1(:ok, "aiueo") == "ok - aiueo"
  assert Hoge.f1(:ng, "aiueo") == "ng - aiueo"

  end
end
