defmodule EliminarDuplicadosOrden do
  @moduledoc """
  Se requiere una función recursiva que reciba una lista y retorne una nueva lista sin elementos repetidos,
  conservando el primer orden de aparición.
  """

  def main do
    lista = ["Iluminador", "Rubor", "Rubor", "Gloss"]
    IO.inspect(eliminacion_elementos_duplicados(lista))
  end

  def eliminacion_elementos_duplicados([]) do
    []
  end

  def eliminacion_elementos_duplicados([head | tail]) do
    resultado = eliminacion_elementos_duplicados(tail)
    if head in resultado do
      resultado
    else
      [head | resultado]
    end
  end
  
end

EliminarDuplicadosOrden.main()
