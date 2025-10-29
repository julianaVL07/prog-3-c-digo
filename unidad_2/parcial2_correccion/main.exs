defmodule Main do
  def main do
    piezas = Pieza.leer_csv("piezas.csv")
    movimientos = Movimiento.leer_csv("movimientos.csv")

    IO.inspect(piezas, label: "\npiezas con el inventario inicial")

    umbral = 50
    piezas_menor_umbral = Pieza.piezas_stock_menor_t(piezas, umbral)
    IO.puts("\nHay #{piezas_menor_umbral} piezas con stock menor a #{umbral} unidades.")

    piezas_actualizadas = Movimiento.aplicar_movimientos(piezas, movimientos)

    IO.inspect(piezas_actualizadas, label: "\nInventario actualizado")

    Movimiento.escribir_csv(piezas_actualizadas, "inventario_actual.csv")

    fecha_inicio = "2025-09-10"
    fecha_fin = "2025-09-11"

    total_piezas_movidas = Movimiento.contar_unidades_en_rango(movimientos, fecha_inicio, fecha_fin)
    IO.puts("\nTotal de unidades movidas entre #{fecha_inicio} y #{fecha_fin}: #{total_piezas_movidas}")

    piezas_sin_repetir = Pieza.eliminar_duplicados_piezas(piezas_actualizadas)
    IO.inspect(piezas_sin_repetir, label: "\nLista de piezas sin duplicados")
  end

end

Main.main()
