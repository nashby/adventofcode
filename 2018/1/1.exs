# https://adventofcode.com/2018/day/1#part1
defmodule Day1A do
  def run do
    File.stream!("1/data.txt")
    |> Enum.reduce(0, fn (i, acc) ->
      {val, _} = Integer.parse(i)
      val + acc
    end)
    |> IO.puts
  end
end

# https://adventofcode.com/2018/day/1#part2
defmodule Day1B do
  def run do
    endless_reducer([0]) |> IO.puts
  end

  defp endless_reducer({:halted, acc}) do
    acc |> hd
  end
  defp endless_reducer(acc) do
    File.stream!("1/data.txt")
    |> Enum.reduce_while(acc, fn (i, acc) ->
      {val, _} = Integer.parse(i)
      next = [val + hd(acc) | acc]

      if val + hd(acc) in acc, do: {:halt, {:halted, next}}, else: {:cont, next}
    end)
    |> endless_reducer
  end
end

Day1A.run
Day1B.run
