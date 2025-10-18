defmodule Detalle do
  defstruct producto: %Producto{}, cantidad: 0

  def crear(producto, cantidad) do
    %Detalle{producto: producto,cantidad: cantidad}
  end

  #Descomponer el detalle para obtener el producto y la cantidad
  def calcular_subtotal(%Detalle{producto: producto, cantidad: cantidad}) do
    producto.precio * cantidad
  end

  def escribir_csv(list_detalles, nombre_archivo) do
    headers = "Nombre, Precio, Cantidad, Subtotal\n"
    contenido =
      Enum.map(list_detalles,
      fn %Detalle{producto: producto, cantidad: cantidad} ->
        "#{producto.nombre }, #{producto.precio}, #{cantidad}, #{calcular_subtotal(%Detalle{producto: producto, cantidad: cantidad})}\n"
      end)
      |> Enum.join()

      File.write(nombre_archivo, headers <> contenido)
  end

  def leer_csv(nombre_archivo) do # Funcion para leer archivo

    case File.read(nombre_archivo) do # Case para manejar errores
      {:ok, contenido} -> # Correcta lectura
        String.split(contenido, "\n") # Separa linea por linea
        |> Enum.map(fn line -> #Recorrer cada linea
          case String.split(line, ", ") do # Separa informacion por coma
            ["Nombre", "Precio", "Cantidad", "Subtotal"] -> nil # Ignorar headers
            [nombre, precio, cantidad, subtotal] -> #Verificar pattern maching
              producto = %Producto{nombre: nombre, precio:
              (if String.contains?(precio, ".") do
                String.to_float(precio)
              else
                String.to_float(precio <> ".0")
              end)} # Crear struct
              %Detalle{producto: producto, cantidad: String.to_integer(cantidad)} # Crear struct
            _ -> nil
          end
        end)
      |> Enum.filter(& &1) # Filtra nil y falsy values

      {:error, reason} -> # Error al leer
        IO.puts("Error al leer el archivo: #{reason}")
        []
    end
  end

  # def mostrar_detalles_con_subtotal(lista_detalles) do  - COMO NO TIENE SUBTOTAL LA ESTRUCTURA DE DETALLE, NO SE LEE
 # Enum.each(lista_detalles, fn detalle ->
    #subtotal = Detalle.calcular_subtotal(detalle)

    #IO.puts("%Detalle{producto: %Producto{nombre: \"#{detalle.producto.nombre}\", precio: #{detalle.producto.precio}}, cantidad: #{detalle.cantidad}, subtotal: #{:erlang.float_to_binary(Float.round(subtotal, 2), decimals: 2)}}")
  #end)
  #end
end
