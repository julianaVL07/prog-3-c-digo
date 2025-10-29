defmodule Docente do

  @moduledoc"""
  C2. Filtrar docentes por categoría.
  Desde docentes.csv con id,nombre,categoria (por ejemplo: “Asistente”, “Asociado”, “Titular”),
  se debe escribir docentes_titulares.csv con solo los docentes cuya categoria sea “Titular”, manteniendo el encabezado.
  """
  defstruct id: "", nombre: "", categoria: ""

  def crear(id, nombre, categoria) do
    %Docente{id: id, nombre: nombre, categoria: categoria}
  end

  def escribir_csv(lista_docentes, nombre_archivo) do
    headers= "Id,Nombre,Categoria\n"
    contenido=
      Enum.map(lista_docentes, fn %Docente{id: id,nombre: nombre, categoria: categoria} ->
        "#{id},#{nombre},#{categoria}\n" end)

      |>Enum.join()
    File.write(nombre_archivo, headers <> contenido)
  end

  def leer_csv(nombre_archivo) do
      case File.read(nombre_archivo) do
      {:ok, contenido} ->
        String.split(contenido, "\n")
        |> Enum.map(fn line ->
          case String.split(line, ",") do
            ["Id","Nombre","Categoria"] -> nil
            [id,nombre,categoria] ->
            %Docente{id: id ,nombre: nombre ,categoria: categoria}
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
