# https://adventofcode.com/2021/day/3
defmodule Day3A do
  def run do
    r = File.stream!("3/data.txt")
    |> Enum.reduce([], fn (diagnostic_number, acc) ->
      String.split(String.trim(diagnostic_number), "", trim: true) |> Enum.with_index |> Enum.map(fn({n, i}) ->
        case n do
          "0" -> [(Enum.at(Enum.at(acc, i) || [], 0) || 0) + 1, Enum.at(Enum.at(acc, i) || [], 1)]
          "1" -> [Enum.at(Enum.at(acc, i) || [], 0), (Enum.at(Enum.at(acc, i) || [], 1) || 0) + 1]
        end
      end)
    end)

    gamma = r |> Enum.map(fn arr -> if Enum.at(arr, 0) > Enum.at(arr, 1), do: 0, else: 1 end) |> Enum.join |> Integer.parse(2) |> elem(0)
    epsilon = r |> Enum.map(fn arr -> if Enum.at(arr, 0) > Enum.at(arr, 1), do: 1, else: 0 end)|> Enum.join|> Integer.parse(2) |> elem(0)

    gamma * epsilon |> IO.inspect
  end
end

defmodule Day3B do
  def oxygen_generator_comparer(list, diagnostic_bit) do
    case diagnostic_bit do
      "0" -> Enum.at(list, 0) <= Enum.at(list, 1)
      "1" -> Enum.at(list, 0) > Enum.at(list, 1)
    end
  end

  def co2_scrubber_comparer(list, diagnostic_bit) do
    case diagnostic_bit do
      "0" -> Enum.at(list, 1) < Enum.at(list, 0)
      "1" -> Enum.at(list, 1) >= Enum.at(list, 0)
    end
  end

  def reject_rating(data, i, _) when length(data) == 1 do
    data
  end

  def reject_rating(data, i, comparer) do
    sums = data
    |> Enum.reduce([0, 0], fn (diagnostic_number, acc) ->
      n = Enum.at(String.split(String.trim(diagnostic_number), "", trim: true), i)

      case n do
        "0" -> [Enum.at(acc, 0) + 1, Enum.at(acc, 1)]
        "1" -> [Enum.at(acc, 0), Enum.at(acc, 1) + 1]
      end

    end)

    data = data |> Enum.reject(fn (diagnostic_number) ->
      n = Enum.at(String.split(String.trim(diagnostic_number), "", trim: true), i)

      comparer.(sums, n)
    end)

    reject_rating(data, i + 1, comparer)
  end

  def run do
    oxygen_generator_rating =
      File.stream!("3/data.txt") |> reject_rating(0, &oxygen_generator_comparer/2) |> Enum.join |> Integer.parse(2) |> elem(0)

    co2_scrubber_rating =
      File.stream!("3/data.txt") |> reject_rating(0, &co2_scrubber_comparer/2) |> Enum.join |> Integer.parse(2) |> elem(0)

    oxygen_generator_rating * co2_scrubber_rating |> IO.inspect
  end
end

Day3A.run # => 2967914
Day3B.run # => 7041258

