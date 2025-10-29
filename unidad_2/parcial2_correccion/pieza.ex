defmodule Pieza do
  defstruct codigo: "", nombre: "", valor: 0, unidad: "", stock: 0

  # A) Leer archivo piezas.csv
  def leer_csv(nombre_archivo) do
  case File.read(nombre_archivo) do
    {:ok, contenido} ->
      String.split(contenido, "\n", trim: true)
      |> Enum.map(fn linea ->
        case String.split(linea, ",") |> Enum.map(&String.trim/1) do
          ["codigo", "nombre", "valor", "unidad", "stock"] -> nil
          [codigo, nombre, valor, unidad, stock] ->
            %Pieza{codigo: codigo,nombre: nombre,valor: String.to_integer(valor),unidad: unidad,stock: String.to_integer(stock)}
          _ -> nil
        end
      end)
      |> Enum.filter(& &1)

    {:error, reason} ->
      IO.puts("Error al leer el archivo: #{reason}")
      []
  end
end

 # B) Contar recursivamente piezas con stock < t, dado un umbral t
  def piezas_stock_menor_t([], t), do: 0

  def piezas_stock_menor_t([hd|tl], t) do
    if hd.stock < t do
      1 + piezas_stock_menor_t(tl, t)
    else
      piezas_stock_menor_t(tl, t)
    end
  end

  # PUNTO 4) Eliminar duplicados de piezas preservando orden de aparicion
  def eliminar_duplicados_piezas([])do
    []
  end

  def eliminar_duplicados_piezas([hd|tl]) do
    if hd in tl do
      eliminar_duplicados_piezas(tl)
    else
      [hd | eliminar_duplicados_piezas(tl)]
    end
  end
end
