defmodule Main do
  def main do
    list_productos= lista_productos()
    IO.inspect(list_productos)
    list_productos_aumento=aumentar_precio(list_productos)
    IO.puts("\nproductos con un aumento del 10%")
    IO.inspect(list_productos_aumento)
    IO.puts("\nproductos con stock mayor a 5")
    #lista_productos_condicion=
    productos_condicion(list_productos)
    #IO.inspect(lista_productos_condicion)
  end

  #Crear una lista de productos, donde cada producto sea un mapa con las claves
  #:nombre, :precio y :stock.
  def lista_productos() do
    [
     %{nombre: "gloss", precio: 6000, stock: 10},
      %{nombre: "sombras", precio: 25000, stock: 3},
      %{nombre: "delineador", precio: 8000, stock: 8}
    ]
  end

  #Usar Enum.map/2 para aumentar en un 10% el precio de todos los productos.
  def aumentar_precio(list_productos) do
      # Enum.map(list_productos, fn producto ->
      #    %{producto | precio: Float.round(producto.precio * 1.10, 2)}  # devuelve todo el mapa con precio modificado #tambien puedo usar solo round que me devuelve enteros
      # end)
      Enum.map(list_productos, fn producto -> Map.put(producto, :precio, Float.round(producto.precio * 1.10, 2))end)
      Enum.map(list_productos, fn producto -> Float.round(producto.precio * 1.10, 2)end)
  end

  #Mostrar solo los nombres de los productos cuyo :stock sea mayor a 5.
  def productos_condicion(list_productos)do
      list_productos_condicion= Enum.filter(list_productos, fn producto -> producto.stock > 5 end)
      Enum.each(list_productos_condicion, fn producto -> IO.puts producto.nombre end)
      #list_productos_condicion  # devolvemos la lista para poder usarla fuera de la función
  end

end

Main.main()
