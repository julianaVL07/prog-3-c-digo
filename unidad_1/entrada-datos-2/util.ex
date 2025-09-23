defmodule Util do
  @doc """
    Displays a message using a Java dialog.
  """
  def show_message(message) do
    System.cmd("java", ["-cp", ".", "Mensaje", message])
  end

  #recibir String
  #def input(message, x) when x==t do
  def input(message, tipo) when tipo== :string do
  System.cmd("java", ["-cp", ".", "Mensaje", "input", message])
  |> elem(0)
  |> String.trim()
  end

  #recibir numero
  def input(message, tipo) when tipo== :integer do
  message
  |>input(:string)
  |>String.to_integer()
  end

  #recibir decimal
   def input(message, tipo) when tipo== :float do
  message
  |>input(:string)
  |>String.to_float()
  end

end


#clausula: conjunto de funiones con misma aridad (cantidad de argumentos) pero cambia el patrón de lo que recibe (string, integer)
#Guarda: condicion extra que le agrego a la funcion
