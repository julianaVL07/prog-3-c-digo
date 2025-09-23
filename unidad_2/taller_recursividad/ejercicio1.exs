defmodule Factorial do
  @moduledoc"""
   Implementar una función recursiva que calcule el factorial de un
   número entero. Caso base: 0! = 1. Caso recursivo: n! = n * (n-1)!. Si el número es negativo, retornar un mensaje de error.
  """
  def main do
    case factorial_numero(5) do #Recursión directa, lineal y no de cola
      :error -> IO.puts("Error, el número no puede ser negativo. ")
      resultado -> IO.puts ("Resultado del factorial es: #{resultado}")
    end
  end

  def factorial_numero(0) do #Caso base
    1
  end

  def factorial_numero(n) do  #Caso recursivo
    n * factorial_numero(n-1)  #llamado recursivo
  end

  def factorial_numero(n) when n < 0, do: :error

end

Factorial.main()
