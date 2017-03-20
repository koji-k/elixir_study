########
# if
#######
test = if String.valid?("aaa") do
  "yes"
else
  "no"
end

IO.puts(test) # yes

test = if is_integer("1") do
  "An Integer"
else
  "Not an Integer"
end
IO.puts test

test = unless is_integer("1") do
  "Not an Integer"
else
  "An Integer"
end
IO.puts test


#########################################################
# case
# ある値にマッチするパターンがあるかどうかチェックする
#########################################################
test = case {:ok, "Hello World"} do
  {:ok, result} ->
    test = "local value"
    "#{result} - #{test}"
  {:error} -> "Uh oh!"
  _ -> "Catch all"
end
IO.puts test

defmodule CaseFunctions do
  def case_guard(arg) do
    case arg do
      {1, x, 6} when x >= 4 -> "x(#{x}) is greater than 4"
      {1, x, 6} when x <= 3 -> "x(#{x}) is less than 3"
      _ -> "ERROR"
    end
  end
end

IO.puts CaseFunctions.case_guard({1, 1, 6}) # x(1) is less than 3
IO.puts CaseFunctions.case_guard({1, 2, 6}) # x(2) is less than 3
IO.puts CaseFunctions.case_guard({1, 3, 6}) # x(3) is less than 3
IO.puts CaseFunctions.case_guard({1, 4, 6}) # x(4) is greater than 4
IO.puts CaseFunctions.case_guard({1, 5, 6}) # x(5) is greater than 4
IO.puts CaseFunctions.case_guard({1, 6, 6}) # x(6) is greater than 4
IO.puts CaseFunctions.case_guard({5}) # ERROR


#########################################################
# cond
# caseと違い、値ではなくて条件をチェックする。
# Javaとかで言うif、else、elseifと同等。もっと見やすい感じ。
# 最後にtrue-> を置いて、マッチしなかった場合のdefaultを指定。
# そうしないと、マッチする条件がない場合にエラーになる。
#########################################################
defmodule CondFunctions do
  def cond_test(x) do
    cond do
      String.valid?(x) -> "This is String..."
      rem(x, 2) == 0 -> "even!"
      rem(x, 2) == 1 -> "odd!"
      true ->  "catch all"
    end
  end
end

IO.puts CondFunctions.cond_test("1") # This is String...
IO.puts CondFunctions.cond_test(1) # odd!
IO.puts CondFunctions.cond_test(2) # even!



#########################################################
# with
#########################################################
defmodule WithFunctions do
  def with_test(some_map) do
    # Map.fetchは、値が存在しない場合は:errorを返す、map(:hoge)のように値がなくてnilなのか、nill自体が格納されいるのか分からない、という問題を対策できる。
    with {:ok, first} <- Map.fetch(some_map, :first),
         {:ok, last} <- Map.fetch( some_map, :last),
         #{:ok, last} <- {:ng, "aaa"}, # こんな値がある場合、マッチしないのでこの時点でこの{:ng, "aaa"}がreturnされる。
         do: "#{last} #{first}"
  end
end

IO.puts WithFunctions.with_test(%{first: "Tarou", last: "Yamada"}) # Yamada Tarou
IO.puts WithFunctions.with_test(%{first: "Tarou", aaa: "Yamada"}) # :error(表示するとerror）パターンマッチングで該当しないものが合った場合、その時点で"マッチしなかった値"を返す

# 上記のwithで、コメントアウトしている処理が動いた場合は、以下のようになる。
# returnされるのはタプルで、タプルはIO.puts出来ない。
# そのためelem(TUPLE, INDEX) で表示したい用ののINDEX番号を指定して、その値のみ表示する必要がある。
#test = WithFunctions.with_test(%{first: "Tarou", last: "Yamada"}) # Yamada Tarou
#IO.puts elem(test, 0)








