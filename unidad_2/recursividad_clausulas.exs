defmodule Recursividad do
  def main do
    matryoshka_recursiva_clausula(5)
  end

  #Directa - lineal - no de cola

  def matryoshka_recursiva_clausula(0) do #caso base
      IO.puts("No hay más muñecas para abrir.")
  end

  def matryoshka_recursiva_clausula(n) do #caso recursivo
      IO.puts("Se abrio la muñeca número #{n}.")
      matryoshka_recursiva_clausula(n-1)   #llamado recursivo
      IO.puts("Se cerro la muñeca número #{n}.")
  end

end

Recursividad.main()
