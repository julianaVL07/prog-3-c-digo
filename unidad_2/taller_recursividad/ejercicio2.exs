defmodule Contar do
  @moduledoc"""
  Diseñar una función recursiva que cuente cuántos elementos tiene una lista.
  """
  def main do
    list=[1,2,3,4,5,6]
    cantidad_elementos_por_recursividad= contar_elementos_por_recursividad(list) #Recursión directa,lineal y no de cola
    IO.puts("Cantidad de elementos que tiene la lista: #{cantidad_elementos_por_recursividad}")
  end

  def contar_elementos_por_recursividad([]) do #Caso base
    0
  end

  def contar_elementos_por_recursividad([hd|tl]) do #Caso recursivo
    1 + contar_elementos_por_recursividad(tl) #llamado recursivo
  end

end

Contar.main()
