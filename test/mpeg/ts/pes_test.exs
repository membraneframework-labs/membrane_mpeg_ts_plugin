defmodule MPEG.TS.PESTest do
  use ExUnit.Case

  alias MPEG.TS.PES
  alias Support.Factory

  describe "Packetized Elementary Stream unmarshaler" do
    test "unmarshals valid payload" do
      payload = Factory.pes_payload
      assert {:ok, %PES{data: _}} = PES.unmarshal(payload, true)
    end

    test "asks for more data when payload is incomplete" do
      short_payload = 
    <<0x0, 0x0, 0x1, 0xE0, 0x0, 0x0, 0x80, 0xC0, 0xA, 0x31, 0x0, 0x9, 0x12, 0xF9,
  0x11, 0x0, 0x7, 0xD8, 0x61, 0x0, 0x0, 0x0, 0x1, 0x9, 0xF0, 0x0, 0x0, 0x0, 0x1,
  0x67, 0x64, 0x0, 0x28, 0xAC, 0xD9, 0x40, 0x78, 0x2, 0x27, 0xE5, 0xC0, 0x44,
  0x0, 0x0, 0x3, 0x0, 0x4, 0x0, 0x0, 0x3, 0x0, 0xC0, 0x3C, 0x60, 0xC6, 0x58,
  0x0, 0x0, 0x0, 0x1, 0x68, 0xEB, 0xE3, 0xCB, 0x22, 0xC0, 0x0, 0x0, 0x1, 0x6,
  0x5, 0xFF, 0xFF, 0xAA, 0xDC, 0x45, 0xE9, 0xBD, 0xE6, 0xD9, 0x48, 0xB7, 0x96,
  0x2C, 0xD8, 0x20, 0xD9, 0x23, 0xEE, 0xEF, 0x78, 0x32, 0x36, 0x34, 0x20, 0x2D,
  0x20, 0x63, 0x6F, 0x72, 0x65, 0x20, 0x31, 0x35, 0x32, 0x20, 0x72, 0x32, 0x38,
  0x35, 0x34, 0x20, 0x65, 0x39, 0x61, 0x35, 0x39, 0x30, 0x33, 0x20, 0x2D, 0x20,
  0x48, 0x2E, 0x32, 0x36, 0x34, 0x2F, 0x4D, 0x50, 0x45, 0x47, 0x2D, 0x34, 0x20,
  0x41, 0x56, 0x43, 0x20, 0x63, 0x6F, 0x64, 0x65, 0x63, 0x20, 0x2D, 0x20, 0x43,
  0x6F, 0x70, 0x79, 0x6C, 0x65, 0x66, 0x74, 0x20, 0x32, 0x30, 0x30, 0x33, 0x2D,
        0x32, 0x30, 0x31, 0x37, 0x20, 0x2D, 0x20, 0x68, 0x74, 0x74, 0x70, 0x3A, 0x2F>>
      assert {:error, :not_enough_data} = PES.unmarshal(short_payload, true)
    end
  end
end
