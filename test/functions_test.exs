defmodule FunctionsTest do

  use ExUnit.Case
  doctest ElixirStudy

  @doc """
  基本的な無名関数の使い方
  """
  test "test1" do

    # 引数無し
    myFunc = fn -> "Anonymous function!" end
    assert myFunc.() == "Anonymous function!"

    # 複数の引数あり
    myFunc2 = fn(x, y) ->
      z = x + y
      z * 2
    end
    assert myFunc2.(2, 3) == 10

    # 上記の無名関数の省略表記バージョン
    # 省略表記の場合は複数行にできない
    myFunc3 = &( (&1 + &2) * 2 )
    assert myFunc3.(2, 3) == 10

    # 以下の2つは全く同じことをしている
    assert 1..5 |> Enum.map(&(&1 * 2)) == [2, 4, 6, 8, 10]
    assert 1..5 |> Enum.map(fn x -> x * 2 end) == [2, 4, 6, 8, 10]
  end

  @doc """
  名前付き関数の使い方
  必ずモジュールの中に定義する必要がある
  引数の数が異なれば、同名のメソッドを複数定義できる。(関数のオーバロード)
  """
  test "test2" do

    defmodule Hoge do
      def hello() do
        "Hello!"
      end

      def hello(name) do
        "Hello #{name}"
      end

      @doc """
      1行で書ける場合は以下のように関数名の後に
      , do:
      を関数を定義できる
      """
      def hello2(name), do: "Hello hello #{name}"
    end

    assert Hoge.hello() == "Hello!"
    assert Hoge.hello("elixir") == "Hello elixir"
    assert Hoge.hello2("elixir") == "Hello hello elixir"
  end




  @doc """
  関数のパターンマッチ
  """
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


  test "anonymous function" do
  end

end
