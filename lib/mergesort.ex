defmodule Mergesort do
  def sort(lst) do
    spawn(Mergesort, :mergesort, [lst, 0, self()])
    receive do
      {:finished, result} -> result
    end
  end

  def mergesort([], _depth, sender) do
    send sender, {:finished, []}
  end
  def mergesort(lst, depth, sender) when length(lst) <= 64 or depth >= 8 do
    send sender, {:finished, Enum.sort lst}
  end
  def mergesort(lst, depth, sender) do
    pieces = Enum.split(lst, div(length(lst), 2))
    {first, second} = pieces
    spawn(Mergesort, :mergesort, [first, depth + 1, self()])
    spawn(Mergesort, :mergesort, [second, depth + 1, self()])

    result_first =
      receive do
        {:finished, result} -> result
      end
    result_second =
      receive do
        {:finished, result} -> result
      end

    send sender, {:finished, merge(result_first, result_second)}
  end

  def merge([], second) do
    second
  end
  def merge(first, []) do
    first
  end
  def merge(first = [ head_first | rest_first ], second = [ head_second | rest_second ]) do
    if head_first < head_second do
      [ head_first | merge(rest_first, second) ]
    else
      [ head_second | merge(first, rest_second) ]
    end
  end
end
