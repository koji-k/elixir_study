  (1..15)
  |> Enum.map(fn i ->
    cond do
      rem(i, 15) == 0 -> "FizzBuzz"
      rem(i, 3) == 0 -> "Fizz"
      rem(i, 5) == 0 -> "Buzz"
      true -> to_string(i)
    end
    end)
  |> Enum.each(&(IO.puts &1))
