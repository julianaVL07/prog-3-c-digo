defmodule Main do
  @moduledoc"""
  Modulo que devuelve un mensaje en mayúsculas
  """

   @doc"""
   Solicita un mensaje al usuario y lo convierte a mayúsculas.
  """
  def main() do
    Util.input_data("Escriba un mensaje: ")
    |> String.upcase()
    |> Util.show_message()
  end
end

Main.main()
