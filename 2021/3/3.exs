# https://adventofcode.com/2021/day/3
defmodule Day3A do
  def run do
    r = File.stream!("3/data.txt")
    |> Enum.reduce([], fn (diagnostic_number, acc) ->
      String.split(String.trim(diagnostic_number), "", trim: true) |> Enum.with_index |> Enum.map(fn({n, i}) ->
        (Enum.at(Enum.at(acc, i) || [], String.to_integer(n)) || 0) + 1
        case n do
          "0" -> [(Enum.at(Enum.at(acc, i) || [], 0) || 0) + 1, Enum.at(Enum.at(acc, i) || [], 1)]
          "1" -> [Enum.at(Enum.at(acc, i) || [], 0), (Enum.at(Enum.at(acc, i) || [], 1) || 0) + 1]
        end
      end)
    end)

    gamma = r |> Enum.map(fn arr -> if Enum.at(arr, 0) > Enum.at(arr, 1), do: 0, else: 1 end) |> Enum.join |> Integer.parse(2) |> elem(0)
    epsilon = r |> Enum.map(fn arr -> if Enum.at(arr, 0) > Enum.at(arr, 1), do: 1, else: 0 end)|> Enum.join|> Integer.parse(2) |> elem(0)

    gamma * epsilon |> IO.inspect
  end
end

Day3A.run

