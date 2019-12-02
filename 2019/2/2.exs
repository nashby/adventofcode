# https://adventofcode.com/2019/day/2

defmodule Intcode do
  def read(path) do
    File.read!(path)
    |> String.split(",")
    |> Enum.map(fn(el) ->
      {val, _} = Integer.parse(el)
      val
    end)
  end

  def replace(intcode, position, value) do
    List.replace_at(intcode, position, value)
  end

  def process(intcode, position) do
    replace_position = Enum.at(intcode, position + 3)
    value_1 = Enum.at(intcode, Enum.at(intcode, position + 1))
    value_2 = Enum.at(intcode, Enum.at(intcode, position + 2))

    case Enum.at(intcode, position) do
      1 ->
        intcode = List.replace_at(intcode, replace_position, value_1 + value_2)
        process(intcode, position + 4)
      2 ->
        intcode = List.replace_at(intcode, replace_position, value_1 * value_2)
        process(intcode, position + 4)
      99 ->
        intcode
    end
  end
end

defmodule Day2A do
  def run do
    intcode = Intcode.read("2/data.txt")
    intcode = Intcode.replace(intcode, 1, 12)
    intcode = Intcode.replace(intcode, 2, 2)

    intcode |> Intcode.process(0)
    |> Enum.at(0)
    |> IO.puts
  end
end

defmodule Day2B do
  def run do
    original_intcode = Intcode.read("2/data.txt")

    try do
      for x <- 0..99, y <- 0..99 do
        intcode = Intcode.replace(original_intcode, 1, x)
        intcode = Intcode.replace(intcode, 2, y)

        if intcode |> Intcode.process(0) |> Enum.at(0) == 19690720 do
          throw([x, y])
        end
      end
    catch
      [x, y] -> IO.inspect(100 * x + y)
    end
  end
end

Day2A.run
Day2B.run

# 3716250
# 6472
