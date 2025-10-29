defmodule Estudiante do
  @moduledoc"""
  S4. Registro de estudiantes.
    Se requiere un struct Estudiante con id, nombre, correo, semestre (entero).
    Una función debe promover el semestre en +1 retornando un nuevo Estudiante, y otra debe validar si el correo
    pertenece al dominio institucional (termina en @uq.edu.co).
  """

  defstruct id: "", nombre: "", correo: "", semestre: 0

  def crear(id, nombre, correo, semestre) do
    %Estudiante{id: id, nombre: nombre, correo: correo, semestre: semestre}
  end

  def promover_semestre(estudiante) do
    semestre= estudiante.semestre
    nuevo_semestre= semestre + 1
    %Estudiante{estudiante | semestre: nuevo_semestre}
  end

  def validar_correo(estudiante) do
    correo = estudiante.correo
    String.ends_with?(correo, "@uq.edu.co")
  end
end
