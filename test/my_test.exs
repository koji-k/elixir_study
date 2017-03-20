defmodule MyTests do
  use ExUnit.Case
  doctest ElixirStudy

  #########################################################################################################################
  # テストの前処理
  # setup_allとsetupが利用できる。
  # それぞれ、戻り値は{:ok, キーワードリスト}という形式にする必要が有る。
  # 各テストメソッドで、"test xxx, state do"と記述すれば、テスト内ではstate[アトム名]でキーワードリストにアクセスできる。
  #########################################################################################################################
  # 全体のテストの前に1回だけ実行される
  setup_all do
      {:ok, hoge: 100}
  end
  # 各テストの前に実行される
  setup do
    {:ok, piyo: 200}
  end

  test "use setupö", state do
    assert 200 == state[:piyo]
    assert 100 == state[:hoge]
    assert is_map(state) == true
  end
end
