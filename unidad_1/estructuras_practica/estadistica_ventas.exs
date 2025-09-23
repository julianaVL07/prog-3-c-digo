defmodule Main do
  def main do
    lista_mapas_ventas=list_mapas_ventas()
    IO.inspect(lista_mapas_ventas)
    suma_total_ventas=suma_total_ventas(lista_mapas_ventas)
    IO.puts("\nSuma total ventas: #{suma_total_ventas}")
    lista_mapas_ventas_agrupadas=agrupar_ventas_producto(lista_mapas_ventas)
    IO.puts("\nLista de mapas agrupados por producto: ")
    IO.inspect(lista_mapas_ventas_agrupadas)
    list_tupla= convertir_mapa_tuplas(lista_mapas_ventas_agrupadas)
    IO.puts("\nMapa agrupado convertido a lista de tuplas: ")
    IO.inspect(list_tupla)
    tupla_producto_mayor_numero_ventas=producto_mayor_ventas(list_tupla)
    IO.puts("\nTupla producto mayor número ventas: ")
    IO.inspect(tupla_producto_mayor_numero_ventas)


  end

  #Una tienda guarda sus ventas en una lista de mapas, cada uno con claves :producto
  #y :monto.
  def list_mapas_ventas() do
    [

    %{producto: "Jabon", monto: 3000},
    %{producto: "Camisa", monto: 50000},
    %{producto: "Pinza",  monto: 2700},
    %{producto: "Jabon", monto: 3000},

  ]
  end

  #Calcular con Enum.reduce/3 la suma total de las ventas.

  def suma_total_ventas(list_mapas_ventas) do
    Enum.reduce(list_mapas_ventas,0, fn venta, acc -> acc+venta.monto end)
  end

  #Usar Enum.group_by/2 para agrupar las ventas por producto.
  def agrupar_ventas_producto(list_mapas_ventas) do
    Enum.group_by(list_mapas_ventas, fn venta -> venta.producto end)
  end

  #Convertir el mapa agrupado en una lista de tuplas {producto, lista_de_ventas}.
  def convertir_mapa_tuplas(list_mapas_ventas_agrupadas) do
    #tupla= Map.to_list(list_mapas_ventas_agrupadas)
    Enum.into(list_mapas_ventas_agrupadas, [])

  end

  #Mostrar el producto con mayor número de ventas usando Enum.max_by/2.
  def producto_mayor_ventas(list_tupla) do
    Enum.max_by(list_tupla,fn {_producto, lista_ventas} -> length(lista_ventas) end) #Devuelve la tupla cuyo segundo elemento (ventas) tenga la mayor longitud.
  end

end

Main.main()

#_producto significa: "sé que existe este valor, pero no lo voy a usar".

#Así evitas la advertencia del compilador "variable no usada".
