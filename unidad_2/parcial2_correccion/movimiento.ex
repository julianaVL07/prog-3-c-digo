defmodule Movimiento do
  defstruct codigo: "", tipo: "", cantidad: 0, fecha: ""

  # A) Aplicar movimientos al stock de piezas
  def aplicar_movimientos(piezas, movimientos) do
  # Recorre todas las piezas y aplica los movimientos que correspondan a cada pieza
  Enum.map(piezas, fn pieza ->
    # Filtrar los movimientos que tienen el mismo código que la pieza
    movimientos_de_pieza =
      Enum.filter(movimientos, fn movimiento ->
        movimiento.codigo == pieza.codigo
      end)

    # Calcular el nuevo stock aplicando cada movimiento
    nuevo_stock = actualizar_stock(pieza.stock, movimientos_de_pieza)

    # Retornar la pieza actualizada con el nuevo stock
    %{pieza | stock: nuevo_stock}
  end)
end

# Si no hay movimientos, el stock se mantiene igual
defp actualizar_stock(stock, [])do
  stock
end

# Aplicar los movimientos de forma recursiva al stock de cada pieza
defp actualizar_stock(stock, [hd|tl]) do
  tipo= hd.tipo
  cantidad= hd.cantidad
  nuevo_stock =
    case tipo do
      "ENTRADA" -> stock + cantidad
      "SALIDA" -> stock - cantidad
      _ -> stock
    end

  actualizar_stock(nuevo_stock, tl)

end

  # B) Guardar inventario actualizado como CSV
  def escribir_csv(piezas, nombre_archivo) do
  headers = "codigo,nombre,valor,unidad,stock\n"

  contenido =
  Enum.map(piezas, fn %Pieza{codigo: codigo, nombre: nombre, valor: valor, unidad: unidad, stock: stock} ->
    "#{codigo},#{nombre},#{valor},#{unidad},#{stock}\n"
  end)
  |> Enum.join()

  File.write(nombre_archivo, headers <> contenido)
end

 # PUNTO 3) Método Recursivo cantidad total unidades movidas de piezas entre fechas
  def contar_unidades_en_rango([], fecha_inicio, fecha_fin)do
    0
  end

  def contar_unidades_en_rango([hd|tl],fecha_inicio,fecha_fin) do
    fecha=hd.fecha
    cantidad=hd.cantidad
    if fecha >= fecha_inicio and fecha <= fecha_fin do
      cantidad + contar_unidades_en_rango(tl, fecha_inicio, fecha_fin)
    else
      contar_unidades_en_rango(tl, fecha_inicio, fecha_fin)
    end
  end

  #leer movimientos
  def leer_csv(nombre_archivo) do
    case File.read(nombre_archivo) do
      {:ok, contenido} ->
        String.split(contenido, "\n", trim: true)
        |> Enum.map(fn linea ->
          case String.split(linea, ",") |> Enum.map(&String.trim/1) do
            ["codigo", "tipo", "cantidad", "fecha"] -> nil
            [codigo, tipo, cantidad, fecha] ->
              %Movimiento{
                codigo: codigo,
                tipo: tipo,
                cantidad: String.to_integer(cantidad),
                fecha: fecha
              }
            _ -> nil
          end
        end)
        |> Enum.filter(& &1)

      {:error, reason} ->
        IO.puts("Error al leer el archivo: #{reason}")
        []
    end
  end
end
