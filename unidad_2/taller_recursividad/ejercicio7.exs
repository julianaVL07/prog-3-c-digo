defmodule SumarNumerosPares do
  @moduledoc """
  Sumar solo los números pares de una lista
  Crear una función recursiva que sume únicamente los números pares de una lista de enteros.
  """

  def main do
    lista_numeros = [1,2,3,4,5,6,7,8,9,10,11,12,13,14,15]
    resultado = suma_numeros_pares(lista_numeros) #Recursión directa, lineal y no de cola.
    IO.puts("La suma de los números pares es: #{resultado}")
  end

  # Caso base
  def suma_numeros_pares([]), do: 0

  # Caso recursivo cuando el número es PAR
  def suma_numeros_pares([h | t]) when rem(h, 2) == 0 do
    h + suma_numeros_pares(t)
  end

  # Caso recursivo cuando el número es IMPAR
  def suma_numeros_pares([_h | t]) do
    suma_numeros_pares(t)
  end

end

SumarNumerosPares.main()
