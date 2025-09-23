defmodule RutasSumaObjetivo do
  @moduledoc """
   Dado un árbol binario de enteros, devolver todas las rutas desde la raíz hasta hojas cuya suma de valores sea igual a un objetivo.
  """

  def main do
    # Definimos un árbol binario:
    #          5
    #        /   \
    #       4     8
    #      /     / \
    #     11    13  4
    #    /  \        \
    #   7    2        5
    arbol = {
      5,
      {4, {11, {7, nil, nil}, {2, nil, nil}}, nil},
      {8, {13, nil, nil}, {4, nil, {5, nil, nil}}}
    }

    objetivo = 22
    rutas=rutas(arbol,objetivo) #Recursión directa, múltiple y no de cola.
    IO.puts("Rutas con suma #{objetivo}: #{inspect(rutas)}")
  end

  # Caso base: árbol vacío, no hay rutas
  def rutas(nil, _objetivo), do: []

  # Caso base: si es hoja (sin hijos)
  def rutas({valor, nil, nil}, objetivo) do
    if valor == objetivo do
      [[valor]]
    else
      []
    end
  end

  # Caso recursivo
  def rutas({valor, izquierda, derecha}, objetivo) do
    nuevo_objetivo = objetivo - valor

    rutas_izquierda = for ruta <- rutas(izquierda, nuevo_objetivo), do: [valor | ruta] #llamado recursivo
    rutas_derecha = for ruta <- rutas(derecha, nuevo_objetivo), do: [valor | ruta] #llamado recursivo

    rutas_izquierda ++ rutas_derecha
  end
end

RutasSumaObjetivo.main()

#<- dentro de un for en Elixir significa “toma cada elemento de la lista y úsalo en esta variable” (muy parecido a for element in list en otros lenguajes).

#El árbol es un tuple con formato {valor, izquierda, derecha}.
#El main busca todas las rutas desde la raíz hasta una hoja cuya suma sea 22.

#inspect/1 dentro de IO.puts para mostrar estructuras (listas, tuplas, mapas…).
#IO.inspect/1 si solo quieres debug rápido sin armar mensajes.
