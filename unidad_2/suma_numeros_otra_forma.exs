defmodule Suma do
  def main do
     resultado=suma_numeros(5)  # directa,lineal y no de cola
     IO.puts("la suma es: #{resultado}")
   end

   def suma_numeros(0) do #Caso base
    0
   end

   def suma_numeros(n) do # Caso recursivo
    n + suma_numeros(n-1) #llamado recursivo (solo la funcion) //este se ejecuta primero y luego ya la suma
   end
end

Suma.main()
