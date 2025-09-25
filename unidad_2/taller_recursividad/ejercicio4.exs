defmodule Buscar do
  @moduledoc"""
  Crear una función recursiva que, dado un elemento y una lista, determine si el elemento está presente (true) o no (false).
  """
  def main do
    elemento= "juan"
    list=["juli","juan","sara"]
    elemento_presente_recursion= elemento_presente_recursion(elemento,list) #Recursión directa, lineal y de cola.
    IO.puts("¿Está #{elemento}? #{elemento_presente_recursion}")
  end

  def elemento_presente_recursion(elemento, []) do #Caso base
    false
  end

  def elemento_presente_recursion(elemento, [elemento | tl]) do #Caso cuando la cabeza coincide
    true
  end

  def elemento_presente_recursion(elemento, [hd | tl]) do #Caso recursivo cuando la cabeza no coincide
    elemento_presente_recursion(elemento, tl) #llamado recursivo
  end

end
Buscar.main()
