Enum.each(1..10, fn i ->
  x = i * 2
  IO.puts(x)
end)

my_func = fn(i) -> IO.puts (i) end
1..10 |> Enum.each(my_func)

