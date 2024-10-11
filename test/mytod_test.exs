defmodule MytodTest do
  use ExUnit.Case
  doctest Mytod

  test "greets the world" do
    assert Mytod.hello() == :world
  end
end
