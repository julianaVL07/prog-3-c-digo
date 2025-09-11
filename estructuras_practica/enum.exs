defmodule Main do
  def main do
    #ejercicio1()
    #ejercicio2()
    # IO.puts("filtrados pares: ")
    # ejercicio3()
    # suma=ejercicio4()
    # IO.puts(suma)
    ejercicio5()
  end

  #Usar Enum.each/2 para imprimir cada número de la lista [1, 2, 3, 4, 5].

  def ejercicio1 do
    list= [1,2,3,4,5]
    Enum.each(list, fn x -> IO.puts x end)
  end

  #Aplicar Enum.map/2 sobre [1, 2, 3, 4] para obtener una nueva lista con sus
  #cuadrados.

  def ejercicio2 do
    list= [1,2,3,4]
    list= Enum.map(list, fn x -> x**2 end)
    IO.inspect(list)
    #IO.inspect(list2) #si quiero mostrar la original y la transformada
  end

  #Usar Enum.filter/2 para obtener solo los números pares de [5, 6, 7, 8, 9, 10].

  def ejercicio3 do
    list=[5,6,7,8,9,10]
    list= Enum.filter(list, fn x -> rem(x,2)==0 end)
    IO.inspect(list)
  end

  #Calcular la suma de los elementos en [10, 20, 30] usando Enum.reduce/2.

  def ejercicio4 do
    list=[ 10,20,30]
    Enum.reduce(list, &+/2)
    #suma=Enum.reduce(list, 0, fn x, acc->  x+acc end )
    #IO.puts(suma)
  end

  #Usar Enum.group_by/2 para agrupar una lista de personas por edad: [%{nombre:
  #"Ana", edad: 20}, %{nombre: "Juan", edad: 25}, %{nombre: "Luis", edad: 20}].

  def ejercicio5 do
    list_personas = [
      %{nombre: "Ana", edad: 20},
      %{nombre: "Juan", edad: 25},
      %{nombre: "Luis", edad: 20}
    ]

    list_agrupadas= Enum.group_by(list_personas, fn persona -> persona.edad end)
    list_agrupadas2= Enum.group_by(list_personas, fn persona -> Map.get(persona, :edad) end)
    IO.inspect(list_agrupadas)
     IO.inspect(list_agrupadas2)
  end

end

Main.main()

#Enum.reduce(lista, inicial, fun) → usas un acumulador inicial que indicas.

#Enum.reduce(lista, fun) → usa el primer elemento de la lista como inicial.

#Si vas a imprimir solo un número, string o boolean, usa IO.puts(valor).

#Si vas a combinar texto con variables, necesitas "texto #{variable}".

#Enum se usa con cualquier colección enumerable.

#Las más comunes son: listas, rangos, mapas y keyword lists.

#Para tuplas → primero conviertes con Tuple.to_list/1.
