defmodule Permutaciones do
  @moduledoc """
  Permutaciones de una lista
  Dada una lista de elementos únicos,
  se requiere generar todas las permutaciones posibles de la lista usando recursividad pura.
  """

  def main do
    lista_elementos_unicos = [1, 2, 3]
    resultado = permutaciones_de_una_lista(lista_elementos_unicos) #Recursión directa, múltiple y no de cola.

    IO.puts("Permutaciones de #{inspect(lista_elementos_unicos)}:")
    Enum.each(resultado, fn perm -> IO.puts("#{inspect(perm)}") end)
  end

  # Caso base: lista vacía → una única permutación (la lista vacía)
  def permutaciones_de_una_lista([]), do: [[]]

  def permutaciones_de_una_lista(lista) do
    for elem <- lista,
        resto <- permutaciones_de_una_lista(lista -- [elem]) do
      [elem | resto]
    end
  end

  def permutaciones_de_una_lista(lista) do
    Enum.flat_map(lista, fn elem ->
    Enum.map(permutaciones_de_una_lista(lista -- [elem]), fn resto ->
      [elem | resto]
    end)
    end)
  end

end

Permutaciones.main()

#flat_map = "aplica un map, pero en vez de dejarte una lista de listas, te devuelve todo junto en una lista única".
#[] = no hay resultados.
#[[]] = un único resultado, que es la lista vacía.
