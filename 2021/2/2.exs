# https://adventofcode.com/2021/day/2
defmodule Day2A do
  def run do
    result = File.stream!("2/data.txt")
             |> Enum.reduce(%{depth: 0, horizontal: 0}, fn (command, acc) ->
               case command do
                 "forward " <> <<number::bytes-size(1)>> <> "\n" ->
                   %{depth: acc.depth, horizontal: acc.horizontal + String.to_integer(number)}
                 "down " <> <<number::bytes-size(1)>> <> "\n" ->
                   %{depth: acc.depth + String.to_integer(number), horizontal: acc.horizontal}
                 "up " <> <<number::bytes-size(1)>> <> "\n" ->
                   %{depth: acc.depth - String.to_integer(number), horizontal: acc.horizontal}
               end
             end)

    result.depth * result.horizontal |> IO.puts
  end
end

defmodule Day2B do
  def run do
    result = File.stream!("2/data.txt")
             |> Enum.reduce(%{depth: 0, horizontal: 0, aim: 0}, fn (command, acc) ->
               case command do
                 "forward " <> <<number::bytes-size(1)>> <> "\n" ->
                   %{depth: acc.depth + acc.aim * String.to_integer(number), aim: acc.aim, horizontal: acc.horizontal + String.to_integer(number)}
                 "down " <> <<number::bytes-size(1)>> <> "\n" ->
                   %{depth: acc.depth, aim: acc.aim + String.to_integer(number), horizontal: acc.horizontal}
                 "up " <> <<number::bytes-size(1)>> <> "\n" ->
                   %{depth: acc.depth, aim: acc.aim - String.to_integer(number), horizontal: acc.horizontal}
               end
             end)

    result.depth * result.horizontal |> IO.puts
  end
end


Day2B.run
