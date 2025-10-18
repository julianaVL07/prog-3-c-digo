defmodule Cliente do
  defstruct nombre: "cliente", cedula: ""

  def crear(nombre,cedula) do
    %Cliente{nombre: nombre,cedula: cedula}
  end

  def escribir_csv(list_clientes, nombre_archivo) do #Funcion para escribir archivo
    headers= "Nombre, Cedula\n"

    contenido=
      Enum.map(list_clientes,
        fn %Cliente{nombre: nombre, cedula: cedula} ->
           "#{nombre}, #{cedula}\n"
      end)
      |>Enum.join() #une listas de cadenas en una sola cadena

    File.write(nombre_archivo, headers <> contenido) #concatena, escribe en el archivo headers (cabeza) y contenido (informacion)
    #si al file se le agg un 3 parametro que sea [:append], no reescribe el archivo sino que agg
  end

  def leer_csv(nombre_archivo) do # Funcion para leer archivo

    case File.read(nombre_archivo) do # Case para manejar errores
      {:ok, contenido} -> # Correcta lectura
        String.split(contenido, "\n") # Separa linea por linea
        |> Enum.map(fn line -> #Recorrer cada linea
          case String.split(line, ", ") do # Separa informacion por coma
            ["Nombre", "Cedula"] -> nil # Ignorar headers
            [nombre, cedula] -> #Verificar pattern maching
              %Cliente{nombre: nombre, cedula: cedula} # Crear struct
            _ -> nil
          end
        end)
         |> Enum.filter(& &1) # Filtra nil y falsy values

      {:error, reason} -> # Error al leer
        IO.puts("Error al leer el archivo: #{reason}")
        []
  end
end
end
