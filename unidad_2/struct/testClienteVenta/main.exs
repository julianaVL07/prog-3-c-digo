defmodule Main do
  def main do
    c1= %Cliente{nombre: "Jhan", cedula: "123"}
    c2= Cliente.crear("Ana", "456")
    c3= Cliente.crear("Luis", "789")
    list_clientes= [c1,c2,c3]
    Cliente.escribir_csv(list_clientes, "clientes.csv")

    list_clientes_leidos = Cliente.leer_csv("clientes.csv")
    IO.inspect(list_clientes_leidos)



    p1= %Producto{nombre: "arroz", precio: 10000}
    p2= %Producto{nombre: "carne", precio: 1000}
    p3= %Producto{nombre: "papa", precio: 500}
    p4= Producto.crear("sushi", 1000)


    d1= %Detalle{producto: p1, cantidad: 1}
    d2= %Detalle{producto: p2, cantidad: 2}
    d3= %Detalle{producto: p3, cantidad: 3}
    d4= Detalle.crear(p4,1)

    list_detalles = [d1, d2, d3, d4]
    Detalle.escribir_csv(list_detalles, "detalles.csv")

    list_detalles_leidos = Detalle.leer_csv("detalles.csv")
    IO.inspect(list_detalles_leidos)
    # Detalle.mostrar_detalles_con_subtotal(list_detalles_leidos) - COMO NO TIENE SUBTOTAL LA ESTRUCTURA DE DETALLE, NO SE LEE


    v1= %Venta{cliente: c1, detalles: [d1,d2,d3,d4]}
    v2= Venta.crear(c2, detalles: [d1,d2,d3])


    Venta.calcular_total(v1)

    |>IO.inspect(label: "Total Venta")
    #IO.inspect(venta, label: "Total Venta")

  end
end

Main.main()
