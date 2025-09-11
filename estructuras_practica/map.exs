defmodule Main do
  def main do
    #ejercicio1()
    #ejercicio2()
    #ejercicio3()
    #ejercicio4()
    ejercicio5()
  end

  #Crear un mapa con claves :nombre, :edad, :ciudad y mostrar el valor de :ciudad.

  def ejercicio1 do
    map= %{nombre: "Jhan", edad: 25, ciudad: "Armenia"}
    map= Map.get(map, :ciudad)
    IO.puts(map)
  end

  #Usar Map.put/3 para agregar la clave :profesion con valor "Ingeniero" a un mapa de
  #persona.

  def ejercicio2 do
    map= %{nombre: "Andres", edad: 20}
    map= Map.put(map, :profesion, "Ingeniero")
    IO.inspect(map)
  end

  #Actualizar el valor de :edad en %{nombre: "Ana", edad: 25} para que ahora sea 26.
  def ejercicio3 do
    map= %{nombre: "Ana", edad: 25}
    map2= Map.put(map, :edad, 26)
    IO.inspect(map)
    IO.inspect(map2)
  end

  #Eliminar la clave :ciudad de %{nombre: "Luis", edad: 30, ciudad: "Cali"}.
  def ejercicio4 do
    map= %{nombre: "Luis", edad: 30, ciudad: "Cali"}
    map2= Map.delete(map, :ciudad)
    IO.inspect(map)
    IO.inspect(map2)
  end

  #Recorrer el mapa %{a: 1, b: 2, c: 3} e imprimir las claves y valores.

  def ejercicio5 do
    map= %{a: 1, b: 2, c: 3}
    #Enum.each(map, fn {clave,valor} -> IO.inspect {clave,valor} end)
    Enum.each(map, fn {clave,valor} -> IO.puts "#{clave}: #{valor}" end)
  end

end

Main.main()
