defmodule Util do
  @doc """
    Displays a message using a Java dialog.
  """
  def show_message(message) do
    System.cmd("java", ["-cp", ".", "Mensaje", message])
  end

  #recibir String
  def input(message, :string) do
  System.cmd("java", ["-cp", ".", "Mensaje", "input", message])
  |> elem(0)
  |> String.trim()
  end

  #recibir numero entero
    #Input con manejo de errores usando try-rescue
  def input(message, :integer) do
    try do
      message
      |> input(:string)
      |> String.to_integer()
    rescue
      ArgumentError ->
        show_message("Error: El valor ingresado no es un entero válido.")

      message
      |> input(:integer)
    end
  end


  #recibir numero decimal
      #Input con manejo de errores usando try-rescue
  def input(message, :float) do
    try do
      message
      numero = input(message, :string)
      numero= String.replace(numero, ",", ".")  #si no contiene punto decimal, agrega ".0" al final
      numero= if String.contains?(numero, ".") do
        numero
      else
        numero <> ".0"
      end
      String.to_float(numero)

    rescue
      ArgumentError ->
        show_message("Error: El valor ingresado no es un decimal válido.")
      message
      |> input(:float)
    end
  end
end


#clausula: conjunto de funiones con misma aridad (cantidad de argumentos) pero cambia el patrón de lo que recibe (string, integer)
#Guarda: condicion extra que le agrego a la funcion
