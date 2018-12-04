defmodule Day3A do
  def run do
    strings = File.read!("3/data.txt")
    |> String.split("\n")

    regexp = ~r/(\d+),(\d+):\s(\d+)+x(\d+)/

    canvas = Enum.reduce(0..(1000 * 1000), %{}, fn(i, acc) ->
      Map.put(acc, i, 0)
    end)

    updated_canvas = Enum.map(strings, fn (string) ->
      [_, x1, y1, width, height] = Regex.run(regexp, string)
      [
        String.to_integer(x1),
        String.to_integer(y1),
        String.to_integer(width),
        String.to_integer(height)
      ]
    end)

    |> Enum.reduce(canvas, fn (rect, canvas) ->
      [x, y, width, height] = rect

      Enum.reduce(y..(y + height - 1), canvas, fn (yy, canvas) ->
        Enum.reduce(x..(x + width - 1), canvas, fn (xx, canvas) ->
          val = canvas[xx + 1000 * yy]
          Map.put(canvas, xx + 1000 * yy, val + 1)
        end)
      end)
    end)

    Map.values(updated_canvas) |> Enum.count(fn (i) -> i >= 2 end)
  end
end

Day3A.run |> IO.inspect

# 103806
