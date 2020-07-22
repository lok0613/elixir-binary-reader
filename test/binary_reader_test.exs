defmodule BinaryReaderTest do
  use ExUnit.Case, async: true
  @moduledoc"""
  <<
  71, 86, 65, 83, # string
  2, 0, 0, 0, # int32
  5, 2, 0, 0, # int32
  4, 0, # int16
  22, 0, # int16
  3, 0,
  0, 0, 0, 0,
  19, 0, 0, 0,
  43, 43, 85, 69, 52, 43, 82, 101, 108, 101, 97, 115, 101, 45, 52, 46, 50....
  """

  setup_all do
    file = Path.relative("test/fixtures/test.binary")
    {:ok, content} = File.read(file)
    {:ok, pid} = BinaryReader.start_link(content)
    {:ok, pid: pid}
  end

  test "read string", %{pid: pid} do
    assert "GVAS" == BinaryReader.read_string(pid)
  end

  test "read int32", %{pid: pid} do
    assert 2 == BinaryReader.read_int32(pid)
    assert 517 == BinaryReader.read_int32(pid)
  end

  test "read int16", %{pid: pid} do
    assert 4 == BinaryReader.read_int16(pid)
  end

  test "read bytes", %{pid: pid} do
    assert <<22, 0>> == BinaryReader.read_bytes(pid, 2)
  end

  test "stop", %{pid: pid} do
    assert :ok == BinaryReader.stop(pid)
  end

end
