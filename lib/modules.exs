#####################################################################
# モジュールの属性
# 以下の@greetingがそれ。ぶっちゃけ定数。
# 関数の中で@greetingに別の値を再代入しようとするとパターンマッチングのエラーになるので、
# 結果的に定数と考えて良いと思う。
#####################################################################
defmodule Example do
  @greeting "Hello"
  def greeting(name) do
    # 以下のように、「~s」で始まる行は""で囲んだ文字列と同じ扱い。
    ~s(#{@greeting} "#{name}")
  end
end

IO.puts Example.greeting("koji")

#####################################################################
# 構造体
# 定義済みのキーとデフォルト値を持つ、特殊なMap。
# ちなみに、特に構造体とは関係ないけど、モジュール名はドットで区切って入れ子に出来る
# その際、親も子もモジュール名の先頭は大文字じゃないとダメ
#####################################################################
defmodule Example.User do
  defstruct name: "Sean", roles: []
end

defmodule Example.Worker do
  def exec do
    %Example.User{} # %Example.User{name: "Sean", roles: []} デフォルト値
    %Example.User{name: 'hoge'} #  %Example.User{name: 'hoge', roles: []}
    %Example.User{roles: [:admin, :employee]} # %Example.User{name: "Sean", roles: [:admin, :employee]}
    %Example.User{name: 'hoge', roles: [:admin, :employee]} # %Example.User{name: 'hoge', roles: [:admin, :employee]}

    # Mapなので、以下のように操作も出来る
    # 更新
    sean = %Example.User{name: 'Sean', roles: [:admin]}
    steve = %{sean | name: "Steve"}
    steve # %Example.User{name: "Steve", roles: [:admin]}
    # 値の取得
    Map.fetch(%Example.User{name: 'hoge'}, :name) |> elem(1) |> IO.puts # hoge
  end
end

Example.Worker.exec

#####################################################################
# コンポジション
#####################################################################

# alias
defmodule Sayings.Test.Greetings do
  def basic(name), do: "Hi, #{name}"
end

defmodule Example2 do
  # aliasを使うことで、最後の実際のモジュール名の指定だけで良くなる。
  # 使わない場合は全部指定(Sayings.Test.Greetings.basic)になる。
  alias Sayings.Test.Greetings
  def greeting(name), do: Greetings.basic(name)
end

IO.puts Example2.greeting("koji") # Hi, koji
