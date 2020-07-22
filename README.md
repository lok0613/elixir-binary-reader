# BinaryReader

A Elixir Binary Reader that running WITH side effects.

## Installation

```elixir
def deps do
  [
    {:binary_reader, "~> 0.1.0"}
  ]
end
```

## Usage

### Normal Usage
```elixir
iex> {:ok, pid} = BinaryReader.start_link(<<65, 66, 67, 68, 2, 0, 0, 0>>)
{:ok, #PID<0.0.0>}
iex> BinaryReader.read_string(pid)
"ABCD"
iex> BinaryReader.remains_byte_size(pid)
4
iex> BinaryReader.read_int32(pid)
2
iex> BinaryReader.stop(pid)
:ok
```

### Extend BinaryReader
```elixir
defmodule SpecialBinaryReader do
  use BinaryReader

  def special_read(pid) do
    length = read_int32(pid)
    read_bytes(pid, length)
  end
end

iex> {:ok, pid} = SpecialBinaryReader.start_link(<<.....>>)
iex> SpecialBinaryReader.special_read(pid)
```
