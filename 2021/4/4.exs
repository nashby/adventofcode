# https://adventofcode.com/2021/day/4
defmodule Day4 do
  def bingo?(board) do
    vertical_bingo?(board) || horizontal_bingo?(board)
  end

  def vertical_bingo?([]) do
    false
  end
  def vertical_bingo?(board) do
    Enum.any?(0..4, fn (column) ->
      board
      |> Enum.with_index
      |> Enum.map(fn ({number, index}) -> if Integer.mod(index - column, 5) == 0, do: number, else: nil end)
      |> Enum.filter(& &1)
      |> Enum.all?(fn (number) -> number == -1 end)
    end)
  end

  def horizontal_bingo?([]) do
    false
  end
  def horizontal_bingo?(board) do
    Enum.any?(1..5, fn (row) ->
      board
      |> Enum.with_index
      |> Enum.map(fn ({number, index}) -> if (index < (row * 5) && index >= (row - 1) * 5), do: number, else: nil end)
      |> Enum.filter(& &1)
      |> Enum.all?(fn (number) -> number == -1 end)
    end)
  end

  def board_score(board, draw_number) do
    score = board
            |> Enum.filter(fn x -> x != -1 end)
            |> Enum.map(fn (x) -> String.to_integer(x) end)
            |> Enum.sum

    score * String.to_integer(draw_number)
  end

  def generate_boards do
    File.stream!("4/data.txt")
    |> Enum.with_index |> Enum.reduce(%{boards: [], board: [], draw_numbers: []}, fn ({data, index}, acc) ->
      data = case index do
        0 ->
          String.split(String.trim(data), ",", trim: true)
        _ ->
          String.split(String.trim(data), " ", trim: true)
      end

      case length(data) do
        5 ->
          %{boards: acc.boards, board: data ++ acc.board, draw_numbers: acc.draw_numbers}
        0 ->
          %{boards: [acc.board | acc.boards], board: [], draw_numbers: acc.draw_numbers}
        _ ->
          %{boards: acc.boards, board: [], draw_numbers: data}
      end
    end)
  end
end

defmodule Day4A do
  def check(boards, draw_numbers) do
    draw_numbers |> Enum.reduce(boards, fn (number, bboards) ->
      bboards |> Enum.map(fn (board) ->
        bboard = board |> Enum.map(fn (board_number) ->
          if board_number == number, do: -1, else: board_number
        end)

        case bboard |> Day4.bingo? do
          true -> raise to_string(Day4.board_score(bboard, number))
          _ -> bboard
        end
      end)
    end)
  end

  def run do
    %{boards: boards, draw_numbers: draw_numbers} = Day4.generate_boards

    check(boards, draw_numbers)
  end
end

defmodule Day4B do
  def check(boards, draw_numbers) do
    draw_numbers |> Enum.reduce(boards, fn (number, bboards) ->
      bboards |> Enum.map(fn (board) ->
        bboard = board |> Enum.map(fn (board_number) ->
          if board_number == number, do: -1, else: board_number
        end)

        case bboard |> Day4.bingo? do
          true ->
            if bboards |> Enum.count == 2, do: raise to_string(Day4.board_score(bboard, number)), else: nil
          _ ->
            bboard
        end
      end) |> Enum.filter(& &1)
    end)
  end

  def run do
    %{boards: boards, draw_numbers: draw_numbers} = Day4.generate_boards

    check(boards, draw_numbers)
  end
end

Day4A.run
Day4B.run
