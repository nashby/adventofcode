# https://adventofcode.com/2022/day/1
defmodule Day1A do
  def run do
    File.read!("1/data.txt")
    |> String.split("\n\n")
    |> Enum.map(&(String.split(&1, "\n", trim: true)))
    |> Enum.map(fn (calories) ->
      calories |> Enum.map(&(String.to_integer(&1))) |> Enum.sum
    end)
    |> Enum.max |> IO.puts
  end
end

defmodule Day1B do
  def run do
    File.read!("1/data.txt")
    |> String.split("\n\n")
    |> Enum.map(&(String.split(&1, "\n", trim: true)))
    |> Enum.map(fn (calories) ->
      calories |> Enum.map(&(String.to_integer(&1))) |> Enum.sum
    end)
    |> Enum.sort(:desc) |> Enum.take(3) |> Enum.sum |> IO.puts
  end
end

Day1A.run # => 68467
Day1B.run # => 1734
