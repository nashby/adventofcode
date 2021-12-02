# https://adventofcode.com/2021/day/1
defmodule Day1A do
  def run do
    File.stream!("1/data.txt")
    |> Enum.chunk_every(2, 1, :discard) |> Enum.map(fn [depth1, depth2] ->
      {depth1, _} = Integer.parse(depth1)
      {depth2, _} = Integer.parse(depth2)

      if depth2 > depth1, do: 1, else: 0
    end)
    |> Enum.sum |> IO.puts
  end
end

defmodule Day1B do
  def run do
    File.stream!("1/data.txt")
    |> Enum.chunk_every(3, 1, :discard) |> Enum.reduce(%{last: :infinity, sum: 0}, fn (window, acc) ->
      sum = window |> Enum.map(fn (depth) -> Integer.parse(depth) |> elem(0) end) |> Enum.sum

      %{last: sum, sum: (if sum > acc.last, do: acc.sum + 1, else: acc.sum)}
    end)
    |> Map.fetch!(:sum) |> IO.puts
  end
end

Day1A.run # => 1713
Day1B.run # => 1734
