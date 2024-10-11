defmodule MytodClient do
  @spec get_time() :: :ok | {:error, atom()}
  def get_time do
    {:ok, socket} = :gen_udp.open(8680)
    :gen_udp.send(socket, {127, 0, 0, 1}, 3787, "")
  end

  @spec decode_time() :: <<_::16>>
  def decode_time do
    "ok"
  end
end
