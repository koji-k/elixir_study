defmodule Comprehensions do
  @module """
  内包表記のテスト
  """
  use ExUnit.Case
  doctest ElixirStudy

  test "base" do
    list = [1, 2, 3, 4, 5]
    assert [2, 4, 6, 8, 10] == for x <- list, do: x * 2
    assert [1, 2, 3, 4, 5] == list
    assert [1, 2, 3, 4, 5] == for x <- 1..5, do: x

    map = %{hoge: 123, piyo: 456}
    assert [123, 456] == for {k, v} <- map, do: v

    keywordList = [ok: 1, ok: 2, ng: 3, ng: 4, ok: 5]
    assert [1, 2, 3, 4, 5] == for {k,v} <- keywordList, do: v

    # 実は内包表記のジェネレータはパターンマッチなので、以下のように出来る。
    # マッチしないものは無視される。
    assert [1, 2, 5] == for {:ok, value} <- keywordList, do: value

    # ネストにも対応
    # なお、doがワンライナーでない場合は、一旦変数に格納してassertしないとsytaxエラーになる。
    result = for x <- [1, 2, 3], y <- 1..x do
     ~s/x(#{x})_y(#{y})/
    end
    assert result == ["x(1)_y(1)", "x(2)_y(1)", "x(2)_y(2)", "x(3)_y(1)", "x(3)_y(2)", "x(3)_y(3)"]

    # フィルタも出来る
    # 無名関数の定義と実行は同時には出来ないみたい。フィルタ部分はあくまで既存の関数の実行。
    isEven = &(rem(&1,2) == 0)
    assert [2, 4, 6, 8, 10] == for x <- 1..10, isEven.(x), do: x
    isEven = fn(x) -> rem(x, 2) == 0 end
    assert [2, 4, 6, 8, 10] == for x <- 1..10, isEven.(x), do: x

    # 複数のフィルタもOK
    # まず偶数を抜き出して、そこからさらに3の倍数を抽出するサンプル
    assert [6, 12, 18] == for x <- 1..20, rem(x,2) == 0, rem(x,3) == 0, do: x

    # ちなみにEnum使うと以下のようになる。
    assert [6, 12, 18] == 1..20
    |> Enum.filter(fn x -> rem(x,2) == 0 end)
    |> Enum.filter(fn x -> rem(x,3) == 0 end)
  end



end
