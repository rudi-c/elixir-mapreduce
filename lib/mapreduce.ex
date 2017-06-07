defmodule Mapreduce do
  @moduledoc """
  """

  require Logger

  def main(_argv) do
    numbers = Enum.shuffle(1..12345678)
    Logger.info "Started"
    IO.puts inspect Mergesort.sort(numbers)
    Logger.info "Finished"
  end
end
