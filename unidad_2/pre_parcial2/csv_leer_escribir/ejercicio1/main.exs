defmodule Main do

  def main do
  # Crear productos de prueba y escribir el archivo productos.csv
  productos = [
    Producto.crear("P01", "Arroz", 2000),
    Producto.crear("P02", "Frijol", 3500),
    Producto.crear("P03", "Azucar", 2500),
    Producto.crear("P04", "Sal", 1000)
  ]

  Producto.escribir_csv(productos, "productos.csv")

  # Leer productos desde el archivo y mostrarlos
  productos_leidos = Producto.leer_csv("productos.csv")
  IO.inspect(productos_leidos, label: "Productos leídos")
  end

  productos_iva = [
    ProductoIva.crear("P01", "Arroz", 2000),
    ProductoIva.crear("P02", "Frijol", 3500),
    ProductoIva.crear("P03", "Azucar", 2500),
    ProductoIva.crear("P04", "Sal", 1000)
  ]


  # Escribir archivo productos.csv con IVA y precio con IVA
  ProductoIva.escribir_csv(productos_iva, "productos_iva.csv")

  # Leer productos desde el archivo productos_iva.csv y mostrarlos
  productos_leidos_iva = ProductoIva.leer_csv("productos_iva.csv")
  IO.inspect(productos_leidos_iva, label: "Productos leídos con IVA")

end

Main.main()
