defmodule Day5 do
  def run do
    chars = File.read!("5/data.txt")
    |> String.split("", trim: true)
    |> delete([], 0)

    chars |> IO.inspect(printable_limit: :infinity)
    chars |> Enum.count |> IO.inspect(printable_limit: :infinity)
  end

  def delete([char_1 | [ char_2 | rest] = ff] = bb, acc, reacted) do
    if is_reacting(char_1, char_2) do
      delete(rest, acc, reacted + 1)
    else
      delete(ff, acc ++ [char_1], reacted)
    end
  end

  def delete([char_1], acc, reacted) do
    delete([], acc ++ [char_1], reacted)
  end

  def delete([], acc, reacted) do
    IO.inspect(reacted)
    IO.inspect(Enum.count(acc))
    if reacted != 0 do
      delete(acc, [], 0)
    else
      acc
    end
  end

  def is_reacting(char1, char2) do
    String.upcase(char1) == String.upcase(char2) && char1 != char2
  end
end


Day5.run

#21590


