defmodule Potencia do
  @moduledoc"""
  Implementar una función recursiva que calcule la potencia de un número base^exponente.
  """
  def main do
      base=2
      exponente=3
      resultado=potencia_numero_recursion(base,exponente) #Recursión directa, lineal y no de cola
      IO.puts("la potencia de #{base} elevado a la #{exponente} es: #{resultado}")
  end

  def potencia_numero_recursion(base, 0) do #Caso base
    1
  end

  def potencia_numero_recursion(base, exponente) do #Caso recursivo
     base * potencia_numero_recursion(base, exponente - 1) #llamado recursivo
  end

end
Potencia.main()
