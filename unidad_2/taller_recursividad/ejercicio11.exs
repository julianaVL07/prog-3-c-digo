defmodule SumaMatriz do
  @moduledoc """
  Sumar todos los elementos de una matriz usando recursividad.
  """
  def main do
    matriz = [
      [1, 2, 3],
      [4, 5, 6],
      [7, 8, 9]
    ]

    resultado = suma_matriz(matriz) #suma_fila/1: recursión directa, lineal, no de cola. suma_matriz/1: recursión directa, lineal, no   de cola (pero además se apoya en otra función).
    IO.puts("La suma de todos los elementos de la matriz es: #{resultado}")
  end

  # Caso base: matriz vacía
  def suma_matriz([]), do: 0

  # Caso recursivo: sumar la primera fila + el resto
  def suma_matriz([h | t]) do
    suma_fila(h) + suma_matriz(t)
  end

  # Caso base: fila vacía
  def suma_fila([]), do: 0

  # Caso recursivo: sumar cabeza + resto de la fila
  def suma_fila([h | t]) do
    h + suma_fila(t)
  end
end

SumaMatriz.main()

#No son dos recursiones al mismo tiempo en una sola función, sino dos funciones distintas que usan recursión por separado.
