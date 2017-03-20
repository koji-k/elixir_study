# Basic anonymous function
sum = fn(a, b) ->
  x = 100
  a + b + x
end
IO.puts(sum.(1, 2))
# 省略記法。ただ、これだと上記のように複数行の処理は書けない。
sum = &(&1 + &2)
IO.puts  sum.(2, 34)

# 関数とパターンマッチング
# 渡された引数によって処理を切り替えることが可能
# 注意点として、このパターンマッチングを用いた関数は、引数の数は必ず同じものでないといけない。
# 引数の数が違う場合は普通に関数をオーバロードをする
handle_result = fn
  1 -> "This is 1!"
  {:ok, result} -> "OK! #{result}"
  _ -> "catch all"
end

IO.puts handle_result.(1) # This is 1!
IO.puts handle_result.({:ok, "hogehoge"}) # OK! hogehoge
IO.puts handle_result.({:ng, "hogehoge"}) # catch all
IO.puts handle_result.(2) # catch all

#################################################
# 名前付き関数
# 必ずモジュールの中に定義する必要がある。
#################################################
defmodule Greeter do
  def hello(name) do
    "Hello, " <> name
  end

  defp hello_private do
    "defpで宣言すると、同じモジュール内の関数からでしか呼べない関数になる。所謂プライベート関数"
  end

  # 1行で書ける場合は、以下のように関数名の後に,を付けてdo:で指定できる（関数本体にendは必要ない）
  def hello2(name), do: "Hello2, " <> name
end

IO.puts Greeter.hello("koji")
IO.puts Greeter.hello2("koji")

# 再帰とパターンマッチ、そしてcons演算子( | )を使って、リストの要素数をカウントするサンプル
# consはhdとtl関数を使っても実現できる。
defmodule Length do
  def of([]), do: 0
  def of([_ | rest]), do: 1 + of(rest)
end
IO.puts Length.of([1, 2, 3, 4, 5])

#################################################
# 関数のオーバロード
#################################################
defmodule Greeter2 do
  def hello(), do: "hello/0"
  def hello(name), do: "hello/1 ---> #{name}"
  def hello(name1, name2), do: "hello/2 ---> #{name1} and #{name2}"
end
IO.puts Greeter2.hello() # hello/0
IO.puts Greeter2.hello('a') # hello/2 ---> a
IO.puts Greeter2.hello('a', 'b') # hello/2 ---> a and b


#################################################
# 関数のガード
# 制御構文のcaseのガード同様、同名同じ引数の関数の中からどれを選ぶかをガードで条件指定することが出来る。
#################################################
defmodule GreeterGuards do
  def hello(names) when is_list(names) do
    names
    |> Enum.join(", ")
    |> hello
  end

  def hello(name) when is_binary(name) do
    phrase() <> name
  end

  defp phrase, do: "Hello, "
end

IO.puts GreeterGuards.hello("a") # "Hello a"
IO.puts GreeterGuards.hello(["a", "b", "c"]) # "Hello, a, b, c"
