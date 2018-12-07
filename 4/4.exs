defmodule Day4 do
  def run do
    strings = File.read!("4/data.txt")
    |> String.split("\n")

    data = Enum.sort_by(strings, fn (str) ->
      parse(str)["datetime"]
    end)
    |> Enum.reduce(%{guards: %{}, last_guard: 0}, fn (str, acc) ->
      a = case parse(str) do
        %{"begins" => "begins", "guard" => guard} ->
          Map.put(acc, :last_guard, guard)
        %{"falls" => "falls asleep", "datetime" => datetime} ->
          guard = acc[:last_guard]
          guard_data = acc[:guards][guard] || %{}
          mins = String.slice(datetime, -2..-1) |> String.to_integer
          guard_data = Map.put(guard_data, :falls, mins)
          Map.put(acc, :guards, Map.put(acc[:guards], guard, guard_data))
        %{"wakes" => "wakes up", "datetime" => datetime} ->
          guard = acc[:last_guard]
          guard_data = acc[:guards][guard] || %{}
          sleep_mins_data = guard_data[:sleep_mins] || []
          sleep_total_data = guard_data[:sleep_total] || 0
          mins = (String.slice(datetime, -2..-1) |> String.to_integer) - 1
          guard_data = Map.put(guard_data, :sleep_mins, sleep_mins_data ++ Enum.to_list(guard_data[:falls]..mins))
          guard_data = Map.put(guard_data, :sleep_total, sleep_total_data + (mins - guard_data[:falls]))
          Map.put(acc, :guards, Map.put(acc[:guards], guard, guard_data))
      end

    end)

    guard = data[:guards] |> Enum.max_by(fn ({id, d}) -> d[:sleep_total] end)
    { id, sleep_data } = guard

    {m, _} = sleep_data[:sleep_mins] |> Enum.group_by(fn (i) -> i end) |> Enum.max_by(fn ({m, mm}) -> Enum.count(mm) end)

    IO.inspect(m * String.to_integer(id))


    ####

    guard = data[:guards] |> Enum.max_by(fn ({id, d}) ->
      d[:sleep_mins] |> Enum.sort |> Enum.chunk_by(fn arg -> arg end) |> Enum.max_by(fn (a) -> Enum.count(a) end) |> Enum.count
    end) |> IO.inspect

    { id, sleep_data } = guard

    ff = sleep_data[:sleep_mins] |> Enum.sort |> Enum.chunk_by(fn arg -> arg end) |> Enum.max_by(fn (a) -> Enum.count(a) end) |> List.last
    ff |> IO.inspect
    IO.inspect(ff * String.to_integer(id))
  end

  def parse(string) do
    regexp = ~r/\[(?<datetime>.+)\] (Guard #(?<guard>\d+) (?<begins>begins)|(?<wakes>wakes up)|(?<falls>falls asleep))/
    Regex.named_captures(regexp, string)
  end
end

Day4.run
