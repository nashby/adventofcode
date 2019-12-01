# https://adventofcode.com/2019/day/1
defmodule Day1A do
  def run do
    File.stream!("1/data.txt")
    |> Enum.reduce(0, fn (i, acc) ->
      {val, _} = Integer.parse(i)
      acc + (trunc(val / 3.0) - 2)
    end)
    |> IO.puts
  end
end

defmodule Day1B do
  def fuel_requirement(mass, acc) when mass <= 0 do
    acc - mass
  end
  def fuel_requirement(mass, acc) when mass > 0 do
    requirement = (trunc(mass / 3.0) - 2)

    fuel_requirement(requirement, acc + requirement)
  end

  def run do
    File.stream!("1/data.txt")
    |> Enum.reduce(0, fn (i, acc) ->
      {val, _} = Integer.parse(i)

      acc + fuel_requirement(val, 0)
    end)
    |> IO.puts
  end
end


Day1A.run
Day1B.run

# 3437969
# 5154075
