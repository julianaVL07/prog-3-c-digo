defmodule Recursividad do
  def main do
    #metodoRecursivo()
    matryoshka_recursiva(5)
  end

  def matryoshka_recursiva(n) do

    if n==0 do #Caso Base
      #codigo
      IO.puts("No hay más muñecas para abrir.")

    else #Caso recursivo
      IO.puts("Se abrio la muñeca número #{n}.")
      matryoshka_recursiva(n-1)   #llamado recursivo
      IO.puts("Se cerro la muñeca número #{n}.")
    end
  end
end

Recursividad.main()
