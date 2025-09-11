defmodule Main do
  def main do
      # entrada= IO.gets("Ingrese una tupla: ") #otra forma en donde se le pide al usuario la tupla
      # {tupla, _} = Code.eval_string(entrada)  # convierte el string en una tupla real
      # ejercicio1(tupla)
      #ejercicio2()
      #numero1=
        #IO.gets("Ingrese un número: ")
        #|> String.trim()
        #|> String.to_integer()
      #numero2=
        #IO.gets("Ingrese otro número: ")
        #|> String.trim()
        #|> String.to_integer()
      #tupla= ejercicio3(numero1,numero2)
      #IO.inspect(tupla)
      #ejercicio4()
      ejercicio5()

  end

  #Crear una tupla con tres elementos: un número, una cadena y un átomo. Luego
  #mostrar el segundo elemento usando elem/2.

  def ejercicio1(tupla) do
    #tupla={10, "Juli", :ok}
    elemento= elem(tupla,2)
    IO.puts(elemento)
  end

  # Dada la tupla {:ok, "Exitoso", 200}, modificar el valor 200 por 404 usando put_elem/3.
  def ejercicio2() do
    tupla1={:ok, "Exitoso", 200}
    tupla2= put_elem(tupla1, 2, 404)
    IO.inspect(tupla1)
    IO.inspect(tupla2)
  end

  #Crear una función que reciba dos números y devuelva una tupla {:ok, resultado} si el
  #divisor es distinto de cero, o {:error, "División por cero"} en caso contrario.
  def ejercicio3(num1Dendo, num2Dsor) do
    if num2Dsor !=0 do
      resultado= num1Dendo / num2Dsor
      #resultado= div(num1Dendo, num2Dsor)
      {:ok, resultado}
    else
      {:error, "División por cero"}
    end
  end

  #Usar pattern matching para extraer los valores de la tupla {:usuario, "Ana", 25} y
  #mostrar nombre y edad.
  def ejercicio4() do
    tupla= {:usuario, "Ana", 25}
    {:usuario, nombre, edad} = tupla #pattern matching
    IO.puts("Nombre: #{nombre}, Edad: #{edad}")
  end

 #Convertir la tupla {:a, :b, :c} en lista y recorrerla imprimiendo cada elemento.

 def ejercicio5 do
   tupla= {:a, :b, :c}
   list= Tuple.to_list(tupla)
   Enum.each(list, fn x -> IO.puts x end)
   #Enum.each(list, fn _ -> nil end)             # recorre sin mostrar nada (no obtiene)
 end

end

Main.main()
