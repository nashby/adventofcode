defmodule Day5 do
  def run do
    chars = File.read!("5/data.txt")
    |> String.split("", trim: true)
    |> delete([])

    chars |> IO.inspect(printable_limit: :infinity)
    chars |> Enum.count |> IO.inspect(printable_limit: :infinity)
  end

  def delete([char_1 | [ char_2 | rest] = ff] = bb, acc) do
    IO.inspect(Enum.count(bb))
    if is_reacting(char_1, char_2) do
      delete(acc ++ rest, [])
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
    String.upcase(char1) == String.upcase(char2) && char1 != char2
  end
end


Day5.run

#21590


