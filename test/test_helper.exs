ExUnit.start()

defmodule TestHelper do
  @doc """
  Formats the time in seconds since 1900 to a human-readable format.
  """
  def format_time(seconds_since_1900) do
    # seconds from 1900 to 1970
    seconds_since_epoch = seconds_since_1900 - 2_208_988_800

    {{year, month, day}, {hour, minute, second}} =
      :calendar.gregorian_seconds_to_datetime(
        seconds_since_epoch + :calendar.datetime_to_gregorian_seconds({{1970, 1, 1}, {0, 0, 0}})
      )

    "#{year}-#{pad(month)}-#{pad(day)} #{pad(hour)}:#{pad(minute)}:#{pad(second)}"
  end

  # Pads single digits with a leading zero for formatting.
  defp pad(n) when n < 10, do: "0#{n}"
  defp pad(n), do: to_string(n)
end
