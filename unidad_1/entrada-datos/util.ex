defmodule Util do
  def show_message(message) do
    message
    |>IO.puts()
  end

  #recibir String
  def input(message, :string)do
  message
  |>IO.gets() #llega String (cadena)
  |>String.trim()
  end

  #recibir numero
  def input(message, :integer) do
  message
  |>input(:string)
  |>String.to_integer()
  end

  #recibir decimal
   def input(message, :float) do
  message
  |>input(:string)
  |>String.to_float()
  end

  #clausula: misma aridad (cantidad de argumentos) pero cambia el patrón de lo que recibe (string, integer)
  #Guarda: condicion extra que le agrego a la funcion

end
