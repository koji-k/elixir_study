defmodule Functions do
  @module """
  Stringの使い方
  """
  use ExUnit.Case
  doctest ElixirStudy

  test "base" do
    # 文字列はバイナリ（バイトシーケンス）
    # 基本的には、Elixirではこの文字列を扱う。
    assert "hello" == <<104, 101, 108, 108, 111>>
    assert is_binary("hello") ==  true
    assert is_list("hello") == false

    # 文字リスト
    # 文字列と違い、シングルクォーテーションで囲むとそれは文字リストになる。
    # リストなので、それぞれの要素にアクセスできる。
    # 各要素の実体は文字コード。
    # ちなみに、"文字列"の場合は、リストではなくてあくまでバイトシーケンスなので、Enum.mapなどに渡すことは出来ない
    assert is_binary('hello') == false
    assert is_list('hello') == true
    assert 'abcd' |> Enum.map(fn char -> to_string(char) end) == ["97", "98", "99", "100"]

    # 文字列から文字リストに変換することも出来る。
    assert "abcd" |> to_charlist |> Enum.map(fn char -> to_string(char) end) == ["97", "98", "99", "100"]

  end


  test "anagrams" do
    defmodule Anagram do
      def anagram?(a, b) when is_binary(a) and is_binary(b) do
        sort_string(a) == sort_string(b)
      end

      def sort_string(string) do
        string
        |> String.downcase
        |> String.graphemes
        |> Enum.sort
      end
    end

    assert Anagram.anagram?("abc", "cba") == true
    assert Anagram.anagram?("ｶﾞｷﾞｸﾞｹﾞｺﾞ", "ｺﾞｹﾞｸﾞｷﾞｶﾞ") == true
    assert Anagram.sort_string("ｺﾞｹﾞｸﾞｷﾞｶﾞ") == ["ｶﾞ", "ｷﾞ", "ｸﾞ", "ｹﾞ", "ｺﾞ"]
  end

end
