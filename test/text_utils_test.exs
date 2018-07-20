defmodule TextUtilsTest do
  use ExUnit.Case
  doctest TextUtils

  test "wrap block" do
    txt = """
    alpha beta gama delta epsilon un doi trei patru cinci șase
    """

    expected = """
    alpha beta gama
    delta epsilon un doi
    trei patru cinci
    șase
    """

    assert TextUtils.wrap(txt, 20) == expected
  end
end
