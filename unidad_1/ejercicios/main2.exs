defmodule Main do
  @moduledoc"""
  Modulo que realiza un conteo de letras
  """

   @doc"""
      Pide una palabra, cuenta sus letras y muestra el resultado.
  """
  def main() do
    Util.input_data("Digite una palabra: ")
    |> String.length()
    |> Integer.to_string() # porque show_message espera un String
    |> Util.show_message()
  end
end

Main.main()
