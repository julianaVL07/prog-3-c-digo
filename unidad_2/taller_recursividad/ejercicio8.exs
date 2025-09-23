defmodule Pedidos do
  @moduledoc"""
  Una tienda almacena sus pedidos en una lista de mapas con claves :producto y :cantidad. Implementar una función recursiva que calcule la cantidad total de productos pedidos.
  """
  def main do
      pedidos=[
            %{producto: "jabón", cantidad: 10},
            %{producto: "gafas", cantidad: 15},
            %{producto: "calculadora", cantidad: 2}
        ]
      cantidad_productos_pedidos=productos_pedidos_recursion(pedidos) #Recursión directa, lineal y no de cola
      IO.puts("La cantidad de productos pedidos en total es: #{cantidad_productos_pedidos}")
  end

  def productos_pedidos_recursion([]) do #Caso base
    0
  end

  def productos_pedidos_recursion([hd | tl]) do #Caso recursivo
    hd.cantidad + productos_pedidos_recursion(tl) #llamado recursivo
  end

end
Pedidos.main()
