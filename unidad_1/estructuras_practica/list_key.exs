defmodule Main do
  def main do
    #ejercicio1()
    #ejercicio2()
    #ejercicio3()
    #ejercicio4()
    ejercicio5()
  end

  #Crear una keyword list que represente un producto con claves :nombre, :precio,
  #:stock.
  def ejercicio1() do
    list_kW = [ nombre: "Cuaderno", precio: 5000, stock: 15]
    IO.inspect(list_kW)
  end

  #Obtener el valor de :precio en la keyword list [nombre: "Camisa", precio: 40000, stock: 12].

  def ejercicio2 do
    list_kw=[nombre: "camisa", precio: 40000, stock: 12 ]
    valor_precio= Keyword.get(list_kw, :precio)
    IO.puts(valor_precio)
    #valor_precio= Keyword.get_values(list_kw, :precio)
    #IO.inspect(valor_precio)
  end

  #Agregar una nueva clave :color con valor "Azul" a la lista anterior.

  def ejercicio3 do
     list_kw=[nombre: "camisa", precio: 40000, stock: 12 ]
     list_kw= Keyword.put(list_kw, :color, "Azul")
     IO.inspect(list_kw)
  end

  # Dada la keyword list [modo: :rapido, modo: :seguro, tiempo: 15], obtener todos los
  #valores de :modo.

  def ejercicio4 do
    list_kw=[modo: :rapido, modo: :seguro, tiempo: 15]
    valores_modo =Keyword.get_values(list_kw, :modo)
    IO.inspect(valores_modo)
  end

  #Iterar sobre la keyword list [usuario: "Carlos", activo: true, rol: "admin"] e imprimir cada
  #clave y valor.

  def ejercicio5 do
    list_kw= [usuario: "Carlos", activo: true, rol: "admin"]
    #Enum.each(list_kw, fn {clave,valor} -> IO.inspect {clave,valor} end) #recorrer una lista (iterar)
    Enum.each(list_kw, fn {clave,valor} -> IO.puts "#{clave}: #{valor}" end) #recorrer una lista
    #valores = Enum.map(list_kw, fn {clave, valor} -> {clave, valor} end) #obtener todos los valores en una lista
    #IO.inspect(valores)
  end
end

Main.main()

# Keyword.put/3 → agrega o reemplaza al inicio.

# ++ → te permite pegar la nueva pareja clave-valor al final.

#Usas color: (con : al final):

#[color: "Azul", talla: "M"]


#Que es exactamente lo mismo que:

#[{:color, "Azul"}, {:talla, "M"}]

#Keyword.get_values/2 → sirve solo para una clave específica (:usuario, :activo, etc.).

#Si quieres todos los valores → usa Enum.each/2.

#Si solo quieres recorrer e imprimir → usa Enum.each.

#Si quieres obtener todos los valores en una lista → usa Enum.map.

#IO.inspect → imprime la estructura interna (útil para depuración).

#IO.puts "#{...}" → imprime un texto legible para el usuario (por eso usamos "" con #{} dentro).

#IO.puts/1 → ✅ imprime texto, enteros y floats.

#IO.inspect/1 → ✅ imprime cualquier tipo de dato (string, número, lista, mapa, tupla…)..

#Si quieres usar IO.puts con otros tipos → conviértelos a string con "#{...}".
