# https://adventofcode.com/2018/day/2#part1
defmodule Day2A do
  def run do
    result = File.read!("2/data.txt")
    |> String.split("\n")
    |> Enum.map(&(String.split(&1, "", trim: true)))
    |> Enum.map(fn (i) -> Enum.group_by(i, &(&1))end)
    |> Enum.reduce(%{double: 0, triple: 0}, fn (map, acc) ->
      double = if Map.values(map) |> Enum.find(fn x -> Enum.count(x) == 2 end), do: 1, else: 0
      triple = if Map.values(map) |> Enum.find(fn x -> Enum.count(x) == 3 end), do: 1, else: 0

      %{double: acc[:double] + double, triple: acc[:triple] + triple}
    end)

    IO.inspect(result[:double] * result[:triple])
  end
end

Day2A.run

# 7470
# %{double: 249, triple: 30}
