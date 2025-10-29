defmodule ConteoCondicionado do
  @moduledoc"""
  Dada una lista de enteros positivos, se requiere una función recursiva que cuente cuántos
  números son múltiplos de 3 o de 5. Debe manejar los casos de lista vacía y listas con un solo elemento.
  """

  def main do
    lista = [1,2,3,4,5,6,7,8,9,10,11,12,13,14,15]
    IO.puts(cantidad_elementos_multiplos(lista))
  end

  #caso base, lista vacia
  def cantidad_elementos_multiplos([]) do
    0
  end

  def cantidad_elementos_multiplos([elem]) do
    if rem(elem, 3)==0 or rem(elem, 5)==0 do
      1
    else
      0
    end
  end

  def cantidad_elementos_multiplos([head|tail]) do
    if rem(head, 3)==0 or rem(head, 5)==0 do
      1 + cantidad_elementos_multiplos(tail)
    else
      cantidad_elementos_multiplos(tail)
    end
  end
end

ConteoCondicionado.main()
