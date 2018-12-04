defmodule Day3 do
  def run do
    strings = File.read!("3/data.txt")
    |> String.split("\n")

    regexp = ~r/#(\d+) @ (\d+),(\d+):\s(\d+)+x(\d+)/

    canvas = Enum.reduce(0..(1000 * 1000), %{}, fn(i, acc) ->
      Map.put(acc, i, [])
    end)

    data = Enum.map(strings, fn (string) ->
      [_, id, x1, y1, width, height] = Regex.run(regexp, string)
      [
        id,
        String.to_integer(x1),
        String.to_integer(y1),
        String.to_integer(width),
        String.to_integer(height)
      ]
    end)

    updated_canvas = data |> Enum.reduce(canvas, fn (rect, canvas) ->
      [id, x, y, width, height] = rect

      Enum.reduce(y..(y + height - 1), canvas, fn (yy, canvas) ->
        Enum.reduce(x..(x + width - 1), canvas, fn (xx, canvas) ->
          coord = xx + 1000 * yy

          ids = canvas[coord]
          Map.put(canvas, coord, ids ++ [id])
        end)
      end)
    end)

    Map.values(updated_canvas) |> Enum.count(fn (ids) -> Enum.count(ids) >= 2 end) |> IO.inspect

    [[id, _, _, _, _]] = data |> Enum.filter(fn (rect) ->
      [id, x, y, width, height] = rect

      Enum.all?(y..(y + height - 1), fn (yy) ->
        Enum.all?(x..(x + width - 1), fn (xx) ->
          coord = xx + 1000 * yy

          updated_canvas[coord] |> Enum.count == 1
        end)
      end)
    end)

    id |> IO.inspect
  end
end

Day3.run

# 103806
# 625
