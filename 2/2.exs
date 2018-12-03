# https://adventofcode.com/2018/day/2#part1
defmodule Day2A do
  def run do
    result = File.read!("2/data.txt")
    |> String.split("\n")
    |> Enum.map(&(String.split(&1, "", trim: true)))
    |> Enum.map(fn (i) -> Enum.group_by(i, &(&1)) end)
    |> Enum.reduce(%{double: 0, triple: 0}, fn (map, acc) ->
      double = if Map.values(map) |> Enum.find(fn x -> Enum.count(x) == 2 end), do: 1, else: 0
      triple = if Map.values(map) |> Enum.find(fn x -> Enum.count(x) == 3 end), do: 1, else: 0

      %{double: acc[:double] + double, triple: acc[:triple] + triple}
    end)

    IO.inspect(result[:double] * result[:triple])
  end
end

Day2A.run

# 7470
# %{double: 249, triple: 30}

defmodule Day2B do
  def run do
    strings = File.read!("2/data.txt")
    |> String.split("\n")
    |> Enum.map(&(String.split(&1, "", trim: true)))

    Enum.with_index(strings)
    |> Enum.each(fn ({string_1, i}) ->
      Enum.slice(strings, (i + 1)..-1)
      |> Enum.each(fn (string_2) ->
        string_zip = Enum.zip(string_1, string_2)
        diff_count = string_zip |> Enum.count(fn ({char_1, char_2}) -> char_1 != char_2 end)

        if diff_count == 1 do
          similar_strings = string_zip |> Enum.filter(fn ({char_1, char_2}) -> char_1 == char_2 end) |> Enum.unzip

          {_, code} = similar_strings
          code |> Enum.join |> IO.inspect
        end
      end)
    end)
  end
end

Day2B.run
