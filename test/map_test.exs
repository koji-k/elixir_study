defmodule MapTest do
  @module """
  Mapの使い方
  """
  use ExUnit.Case
  doctest ElixirStudy

  test "base" do

    # Mapの生成と取得
    base_map = %{:hoge => "piyo",:foo => "bar"}
    assert base_map[:hoge] == "piyo"
    assert base_map[:foo] == "bar"
    assert base_map == %{hoge: "piyo", foo: "bar"}
    assert base_map.hoge == "piyo"
    assert base_map.foo == "bar"
    assert base_map[:test] == nil
    # assert base_map.test == nil # そんなatomがMapniないので、この書き方はエラーになる

    # 取得の他の方法
    # Map.fetchを使うことで、値が存在しない場合には通常nilが返るが、その代わりに:errorを返すことが出来る。
    assert Map.fetch(base_map, :test) == :error
    assert Map.fetch(base_map, :hoge) == {:ok, "piyo"}
    assert Map.fetch(base_map, :hoge) |> elem(0) == :ok
    assert Map.fetch(base_map, :hoge) |> elem(1) == "piyo"

    # Mapの更新
    # 特別な構文がある。なお、新しいMapを作成して返すので、元のMapに変化はない。
    # この方法は出来ない。
    #base_map[:hoge] = "updated"
    #base_map.hoge = "updated"
    base_map2 = %{base_map | hoge: "updated"}
    assert base_map.hoge == "piyo"
    assert base_map.foo == "bar"
    assert base_map2.hoge == "updated"
    assert base_map2.foo == "bar"

  end
end
