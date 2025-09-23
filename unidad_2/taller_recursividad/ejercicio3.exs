defmodule Transacciones do
  @moduledoc """
  Sumar transacciones financieras (ingresos y gastos)
  usando recursividad.
  """
  def main do
    transacciones = [20000, 50000, 80000, -40000, -60000]
    resultado = balance_final(transacciones)    #estado financiero #Recursión directa, lineal y no de cola.
    IO.puts("El balance final de las transacciones es: #{resultado}")
  end

  # Caso base: cuando no hay más transacciones, el balance es 0
  def balance_final([]), do: 0

  # Caso recursivo: suma la cabeza con el balance del resto
  def balance_final([h | t]) do
    h + balance_final(t)
  end
end

Transacciones.main()
