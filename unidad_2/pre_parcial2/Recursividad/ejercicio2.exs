defmodule MaximoMinimo do
 @moduledoc"""
  Se pide una función recursiva que retorne una tupla {min, max} de una lista de enteros.
  En caso de lista vacía, debe retornar {:error, :lista_vacia}.
 """

  def main do
    lista = [1,2,3,4,5]
    IO.inspect(minimo_maximo(lista))
  end

  def minimo_maximo([]) do
    {:error, :lista_vacia}
  end

  def minimo_maximo([elem]) do
    {elem, elem}
  end

  def minimo_maximo([head |tail]) do
    {min_tail, max_tail} = minimo_maximo(tail)
    min = if head < min_tail do
      head
    else
      min_tail
    end
    max = if head > max_tail do
      head
    else
      max_tail
    end
    {min, max}
  end

end

MaximoMinimo.main()
