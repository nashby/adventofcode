defmodule Day3A do
  def run do
    strings = File.read!("3/data.txt")
    |> String.split("\n")

    regexp = ~r/(\d+),(\d+):\s(\d+)+x(\d+)/

    canvas = Enum.map(1..1000, fn(row) ->
      Enum.map(1..1000, fn(column) ->
        0
      end)
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
    |> Enum.reduce(canvas, fn (rect, canvas_tt) ->
      [x, y, width, height] = rect
      IO.inspect(rect)
      Enum.reduce(y..height, canvas_tt, fn (yy, canvas_ee) ->
        Enum.reduce(x..width, canvas_ee, fn (xx, canvas_acc) ->
          val = Enum.at(Enum.at(canvas_acc, yy - 1), xx - 1)
          List.replace_at(canvas_acc, yy - 1, List.replace_at(Enum.at(canvas_acc, yy - 1), xx - 1, val + 1))
        end)
      end)
    end)

    updated_canvas |> IO.inspect
  end
end

Day3A.run
