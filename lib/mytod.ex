# lib/time_server.ex
defmodule Mytod do
  use GenServer

  require Logger

  ## Client API
  def start_link(_opts) do
    GenServer.start_link(__MODULE__, %{}, name: __MODULE__)
  end

  ## Server Callbacks
  @impl true
  def init(_args) do
    Logger.info("Starting TimeServer...")
    :gen_udp.open(3787, [:binary, active: true])
  end

  @impl true
  def handle_info({:udp, _socket, ip, port, _message}, socket) do
    Logger.info("Received UDP packet from #{inspect(ip)}:#{port}")
    response = :binary.encode_unsigned(get_time_offset(), :big)
    Logger.info("Sending #{get_time_offset()}")
    :gen_udp.send(socket, ip, port, response)
    {:noreply, socket}
  end

  def get_time_offset do
    :calendar.datetime_to_gregorian_seconds(:calendar.universal_time()) -
      :calendar.datetime_to_gregorian_seconds({{1900, 1, 1}, {0, 0, 0}})
  end

  @impl true
  def terminate(_reason, socket) do
    :gen_udp.close(socket.socket)
    Logger.info("TimeServer terminated")
    :ok
  end
end
