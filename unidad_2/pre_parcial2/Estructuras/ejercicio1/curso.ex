defmodule Curso do

  @moduledoc"""
  S1. Catálogo de cursos.
  Se requiere un struct para representar un curso con campos: codigo, nombre, creditos, docente.
  Adicionalmente, se solicita una función que valide si un curso es de alta carga (≥ 4 créditos)
  y otra que cambie el docente asignado retornando una nueva instancia.
  """

  defstruct codigo: "", nombre: "", creditos: 0, docente: %Docente{}

  def crear(codigo, nombre, creditos, docente) do
    %Curso{codigo: codigo, nombre: nombre, creditos: creditos, docente: docente}
  end

  def curso_de_alta_carga(curso) do
    if curso.creditos >= 4 do
      true
    else
      false
    end
  end

  def asignar_nuevo_docente(curso, nuevo_docente ) do
    %Curso{curso | docente: nuevo_docente}
  end
end
