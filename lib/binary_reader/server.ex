defmodule BinaryReader.Server do
  use GenServer

  @impl true
  def init(content) do
    {:ok, content}
  end

  @impl true
  def handle_call({:read_bytes, size}, _from, content) do
    <<head::binary-size(size), rest::binary>> = content
    {:reply, head, rest}
  end

  @impl true
  def handle_call(:read_int64, _from, content) do
    <<head::binary-size(8), rest::binary>> = content
    <<int64::little-signed-integer-size(64)>> = head

    {:reply, int64, rest}
  end

  @impl true
  def handle_call(:read_int32, _from, content) do
    <<head::binary-size(4), rest::binary>> = content
    <<int32::little-signed-integer-size(32)>> = head

    {:reply, int32, rest}
  end

  @impl true
  def handle_call(:read_int16, _from, content) do
    <<head::binary-size(2), rest::binary>> = content
    <<int32::little-signed-integer-size(16)>> = head

    {:reply, int32, rest}
  end

  @impl true
  def handle_call(:read_string, _from, content) do
    <<head::binary-size(4), rest::binary>> = content

    string = head
    |> :binary.bin_to_list()
    |> to_string()

    {:reply, string, rest}
  end

  @impl true
  def handle_call({:move_pivot_to, index}, _from, content) do
    <<_head::binary-size(index), rest::binary>> = content
    {:reply, :ok, rest}
  end

  @impl true
  def handle_call(:remains_byte_size, _from, content) do
    {:reply, byte_size(content), content}
  end

end
