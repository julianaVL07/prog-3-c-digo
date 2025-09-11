defmodule Main do
  def main do
    #ejercicio1()
    ejercicio2()
    #ejercicio3()
    #list=[1,2,3,4,5]
    #ejercicio4(list)
    #ejercicio5()
  end

  # Crear una lista con los nombres de cinco ciudades y mostrar la primera (cabeza) y el
  # resto (cola).

  def ejercicio1() do
      list= [ " Manizales", " Pereira", " Armenia", " Bogota", " Cali"]
      [head | tail] =list
      IO.puts("Cabeza: #{head}")
      IO.puts("Cola: #{tail}")
  end

  #Concatenar dos listas de números [1, 2, 3] y [4, 5, 6], y luego mostrar el resultado.

  def ejercicio2() do
    list= [1,2,3]
    list2= [4,5,6]
    list=list ++ list2
    IO.inspect(list) #mostrar los elementos de la lista
  end

# Dada una lista [10, 20, 30, 40, 50], restar [20, 50] y mostrar el resultado.

  def ejercicio3() do
    list= [10,20,30,40,50]
    list= list -- [20,50]
    IO.inspect(list)
  end

  #Escribir una función que reciba una lista de números y devuelva una nueva lista con
  #todos los valores multiplicados por 3.

  def ejercicio4(list) do
    #list= [1,2,3,4,5]
    list= Enum.map(list, fn x -> x*3 end)
    IO.inspect(list)
  end

  #Desestructurar la lista [100, 200, 300] en variables a, b, c y mostrar cada una.

  def ejercicio5() do
    list=[100,200,300]
    [a, b, c]= list
    IO.puts(a)
    IO.puts(b)
    IO.puts(c)
  end
end


Main.main()
