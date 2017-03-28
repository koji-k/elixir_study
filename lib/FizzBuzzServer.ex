defmodule FizzBuzzServer do
  @moduledoc "FizzBuzzServerだよ"

  @doc """
  こいつがsendを待ち受ける
  こんな感じで呼び出せる。

  pid = spawn(FizzBuzzServer, :compute, [])
  1..15 |> Enum.map( &(send(pid, &1)) )

  Enum.mapは、第１引数に自動的に1..15を受け取る。（|>がそうしてる）
  で、その値をsendに渡したいけどパイプ演算子の場合はその変数名が無いので困る。
  そこで、無名関数を利用して、Enum.map自体が関数に渡してくる値を受け取るようにしている。
  なので、以下のようにな呼び方でも全く同じ。
  1..15 |> Enum.map(fn x -> send pid, x end)
  Enum.map(1..15, fn x -> send pid, x end)
  """

  def compute do
    receive do
      n ->
        IO.puts (inspect self())
        IO.puts "#{n}: #{compute(n)}"
    end
    compute()
  end

  def compute(n) do
    case {rem(n, 3), rem(n, 5)} do
      {0, 0} -> :FizzBuzz
      {0, _} -> :Fizz
      {_, 0} -> :Buzz
      _ -> n
    end
  end
end

# このモジュールを使って、iexじゃなくてプログラムから実際にProcessを扱う際の挙動を確認できる（といってもやってることも挙動もiexと同じ）
defmodule FizzBuzzClient do
  def run do
    {pid, ref}= spawn_monitor(FizzBuzzServer, :compute, [])
    receive do
      x when is_number(x) ->
        IO.puts "FizzBuzzServer alive? #{Process.alive?(pid)}"
        send pid, x
      {:DOWN, ref2, :process, from_pid, reason} -> IO.puts "Exit reason: #{inspect reason}"
    end
    run()
  end

  # こちらは、もしFizzBuzzServerが落ちた場合、このプロセス自体(FizzBuzz#run_as_single)も落ちる。
  # Process.alive?/1はfalseを返す。
  # pid = spawn(FizzBuzzClient, :run_as_link, [])
  def run_as_link do
    pid = spawn_link(FizzBuzzServer, :compute, [])
    receive do
      x -> send pid, x
    end
    run_as_link()
  end

  # こちらは、もしFizzBuzzServerが落ちても、このプロセス自体(FizzBuzz#run_as_single)は死なない。
  # Process.alive?/1はtrueを返す。
  # pid = spawn(FizzBuzzClient, :run_as_single, [])
  def run_as_single do
    pid = spawn(FizzBuzzServer, :compute, [])
    receive do
      x -> send pid, x
    end
    run_as_single()
  end

end
