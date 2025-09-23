defmodule Ejercicio do
  def main do
      suma= suma_numeros(5)
      IO.puts(suma)
  end

  def suma_numeros(0) do
    0
  end

  def suma_numeros(n) do
    n + suma_numeros(n-1)
  end

end

Ejercicio.main()
