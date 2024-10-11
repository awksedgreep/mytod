# test/time_server_test.exs
defmodule MytodTest do
  use ExUnit.Case
  require Logger
  doctest Mytod

  @port 3787

  setup do
    #{:ok, _pid} = Mytod.start_link([])

    {:ok, socket} =
      :gen_udp.open(0, [:binary, active: false, reuseaddr: true])
    {:ok, socket: socket}
  end

  test "server responds with the time of day", %{socket: socket} do
    # Send an empty message to the server
    :gen_udp.send(socket, {127, 0, 0, 1}, @port, "")
    {:ok, { _host, _port, response} } = :gen_udp.recv(socket, 0)
    # Decode the response
    time_offset = :binary.decode_unsigned(response, :big)
    Logger.info("Received #{time_offset}")
    Logger.info("Translatest to #{TestHelper.format_time(time_offset)}")
  end
end
