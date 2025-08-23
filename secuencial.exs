defmodule Secuencia do #modulo -> UpperCamelCase
def mostrar_mensaje() do
  "Mensaje desde una función"
  |> IO.puts()
end

#Funcion de una sola linea -> snake_case
  def mostrar_mensaje_unalinea(), do: IO.puts("Hola a todos")

  #Funcion privada -> snake_case
  defp mostrar_mensaje_privado(mensaje) do
    mensaje
    |> IO.puts()
  end

  def invocacion_privado() do
    "mensaje privado desde una función"
    |> mostrar_mensaje_privado()
  end
end

Secuencia.invocacion_privado()
Secuencia.mostrar_mensaje()
Secuencia.mostrar_mensaje_unalinea()

# (condicion) ? true : false
