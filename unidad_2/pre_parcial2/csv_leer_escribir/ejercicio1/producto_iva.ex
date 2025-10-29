defmodule ProductoIva do

  @moduledoc"""
  C1. Leer productos y calcular IVA.
  A partir de productos.csv con columnas codigo,nombre,precio, se requiere leer los registros
  y generar un segundo archivo productos_iva.csv con codigo,nombre,precio,iva,precio_con_iva usando una tasa fija del 19%.
  """

  defstruct codigo: "", nombre: "", precio: 0, iva: 0.19, precio_con_iva: 0

  def crear(codigo, nombre, precio) do
    iva = 0.19
    precio_con_iva = precio + (precio * iva)
    %ProductoIva{codigo: codigo, nombre: nombre, precio: precio, iva: iva, precio_con_iva: precio_con_iva}
  end

  def calcular_precio_con_iva(producto) do
    producto.precio * producto.iva + producto.precio
  end

  def escribir_csv(lista_productos, nombre_archivo) do
    headers= "Codigo,Nombre,Precio,Iva,PrecioIva\n"

    contenido=
      Enum.map(lista_productos, fn %ProductoIva{codigo: codigo, nombre: nombre, precio: precio, iva: iva, precio_con_iva: precio_con_iva} ->
        "#{codigo},#{nombre},#{precio},#{iva},#{precio_con_iva}\n"end)
    |>Enum.join

    File.write(nombre_archivo, headers <> contenido)
  end

  def leer_csv(nombre_archivo) do

    case File.read(nombre_archivo) do
      {:ok, contenido} ->
        String.split(contenido, "\n")
        |> Enum.map(fn line ->
          case String.split(line, ",") do
            ["Codigo","Nombre","Precio","Iva","PrecioIva"] -> nil
            [codigo,nombre,precio,iva,precioiva] ->
            %ProductoIva{codigo: codigo, nombre: nombre, precio:
              (if String.contains?(precio, ".") do
                String.to_float(precio)
              else
                String.to_float(precio <> ".0") end)}
            _-> nil
          end
        end)
        |> Enum.filter(& &1)

        {:error, reason} ->
          IO.puts("Error al leer el archivo: #{reason}")
          []
      end
  end
end
