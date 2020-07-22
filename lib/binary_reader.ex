defmodule BinaryReader do
  @moduledoc """
  Warning: This module has side effects.

  a_int = BinaryReader.read_int32(pid)

  Each action like this will cost a side effect, chaging the binary content that inputed initailly.
  Be careful to use it according to your needs.
  """
  alias BinaryReader.Server

  defmacro __using__(_opt) do
    quote do
      import BinaryReader
    end
  end

  @doc """
  Start the GenServer
  """
  @spec start_link(binary()) :: {:ok, pid()}
  def start_link(content) do
    GenServer.start_link(Server, content)
  end

  @doc """
  Stop the GenServer
  """
  @spec stop(pid()) :: :ok
  def stop(pid), do: GenServer.stop(pid, :normal)

  @doc """
  Read one byte
  """
  @spec read_byte(pid()) :: binary()
  def read_byte(pid), do: read_bytes(pid, 1)

  @doc """
  Read number of bytes
  """
  @spec read_bytes(pid(), integer()) :: binary()
  def read_bytes(pid, size) when is_integer(size) do
    GenServer.call(pid, {:read_bytes, size})
  end

  @doc """
  Read 8 bytes for int64
  """
  @spec read_int64(pid()) :: integer()
  def read_int64(pid), do: GenServer.call(pid, :read_int64)

  @doc """
  Read 4 bytes for int32
  """
  @spec read_int32(pid()) :: integer()
  def read_int32(pid), do: GenServer.call(pid, :read_int32)

  @doc """
  Read 2 bytes for int16
  """
  @spec read_int16(pid()) :: integer()
  def read_int16(pid), do: GenServer.call(pid, :read_int16)

  @doc """
  Read 4 bytes for string
  """
  @spec read_string(pid()) :: String.t()
  def read_string(pid), do: GenServer.call(pid, :read_string)

  @doc """
  Return remains size of bytes
  """
  @spec remains_byte_size(pid()) :: binary()
  def remains_byte_size(pid), do: GenServer.call(pid, :remains)

  @doc """
  Move the reading pivot to certain index
  """
  @spec move_pivot_to(pid(), integer()) :: :ok
  def move_pivot_to(pid, index) when is_integer(index) do
    GenServer.call(pid, {:move_pivot_to, index})
  end

end
