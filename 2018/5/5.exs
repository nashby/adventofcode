defmodule Day5 do
  def run do
    data = File.read!("5/data.txt")
    chars = data |> String.trim |> String.to_charlist

    chars  = chars |> delete([])
    chars |> Enum.count |> IO.inspect(printable_limit: :infinity)

    ?a..?z |> Enum.map(fn (char) ->
      IO.inspect char
      data
      |> String.trim
      |> String.replace(~r/#{<<char :: utf8>>}/i, "")
      |> String.to_charlist
      |> delete([])
      |> Enum.count
    end)
    |> Enum.min
    |> IO.inspect
  end

  def delete([char_1 | [ char_2 | rest] = ff] = bb, [] = acc) do
    if is_reacting(char_1, char_2) do
      delete(rest, acc)
    else
      delete(ff, acc ++ [char_1])
    end
  end

  def delete([char_1 | [ char_2 | rest] = ff] = bb, acc) do
    if is_reacting(char_1, char_2) do
      [head | tail] = Enum.reverse(acc)
      delete([head] ++ rest, Enum.reverse(tail))
    else
      delete(ff, acc ++ [char_1])
    end
  end

  def delete([char_1], acc) do
    delete([], acc ++ [char_1])
  end

  def delete([], acc) do
    acc
  end

  def is_reacting(char1, char2) do
    abs(char1 - char2) == 32
  end
end


Day5.run

#part 1 = 11636
#part 2 = 5302


