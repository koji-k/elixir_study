# ElixirStudy

**TODO: Add description**

## Installation

If [available in Hex](https://hex.pm/docs/publish), the package can be installed
by adding `elixir_study` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [{:elixir_study, "~> 0.1.0"}]
end
```

Documentation can be generated with [ExDoc](https://github.com/elixir-lang/ex_doc)
and published on [HexDocs](https://hexdocs.pm). Once published, the docs can
be found at [https://hexdocs.pm/elixir_study](https://hexdocs.pm/elixir_study).

# メモ
lib/配下にソースを配置していく。  
その際、ディレクトリを深くほってそこにコードを配置してもいいけど、モジュール名とディレクトリ名は異なっていてもOK。  
なお、`mix compile`でElixirをコンパイルできるが、拡張子が`.es`のものだけ。`exs`はコンパイルされないので注意。  
また、コンパイルと同時に実行もされているっぽい。なので、moduleの外に`IO.puts`とか書いてると、`mix compie`すると実行される。

以下の様の実行出来る。

```elixir
mix compile
mix run -e "IO.puts My.Module.function()"
```

iexからもOK

```
iex -S mix
FizzBuzz.upto(100)

# 以下を実行すれば、lib/配下のファイルをコンパイルして読み込みなおしてくれる。
recompile()
```

