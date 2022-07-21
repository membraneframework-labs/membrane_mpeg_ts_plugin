defmodule MPEG.TS.PAT do
  @moduledoc """
  Program Association Table.
  """

  @type program_id_t :: 0..65_535
  @type program_pid_t :: 0..8191
  @type pat_t :: %{required(program_id_t()) => program_pid_t()}

  @entry_length 4

  # Unmarshals Program Association Table data. Each entry should be 4 bytes
  # long. If provided data length is not divisible by entry length an error
  # shall be returned.
  @spec unmarshal(binary) :: {:ok, pat_t()} | {:error, :malformed_data}
  def unmarshal(data) when rem(byte_size(data), @entry_length) == 0 do
    programs =
      for <<program_number::16, _reserved::3, pid::13 <- data>>,
        into: %{} do
        {program_number, pid}
      end

    {:ok, programs}
  end

  def unmarshal(_) do
    {:error, :malformed_data}
  end
end
