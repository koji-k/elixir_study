defmodule FizzBuzz do
  def fizzbuzz(n) do
    cond do
      rem(n, 15) == 0 -> "FizzBuzz"
      rem(n, 3) == 0 -> "Fizz"
      rem(n, 5) == 0 -> "Buzz"
      true -> to_string(n)
    end
  end

  # 意味は無いけどパイプライン演算子を使っている
  def upto(n) do
    1..n |> Enum.each(fn i ->
      i |> fizzbuzz |> IO.puts
    end)
  end
end

FizzBuzz.upto(100)
