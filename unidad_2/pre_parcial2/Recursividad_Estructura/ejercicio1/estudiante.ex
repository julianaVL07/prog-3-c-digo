defmodule Estudiante do

  @moduledoc"""
  RS1. Promedio de calificaciones por estudiante.
  Con una lista de %Estudiante{} donde cada estudiante tiene un campo notas (lista de enteros),
  se requiere una función recursiva que calcule el promedio por estudiante y
  retorne una lista de tuplas {id, promedio}
  sin usar Enum.sum/1. Definir el struct necesario.
  """

  defstruct id: "", nombre: "", notas: []

  def crear(id, nombre, notas) do
    %Estudiante{id: id, nombre: nombre, notas: notas}
  end


  #Sumar notas recursivamente
  def sumar_notas([]) do
    0
  end

  def sumar_notas([cabeza|cola]) do
    cabeza + sumar_notas(cola)
  end

  #Contar cantidad notas
  def contar_notas([]) do
    0
  end

  def contar_notas([cabeza|cola]) do
    1 + contar_notas(cola)
  end


  #Calcular promedio por estudiante
  def calcular_promedios([]) do
    []
  end

  def calcular_promedios([cabeza| cola]) do
    notas= cabeza.notas
    total_suma_notas= sumar_notas(notas)
    cantidad_notas= contar_notas(notas)
    promedio= total_suma_notas/ cantidad_notas
    [{cabeza.id, promedio} | calcular_promedios(cola)]
  end

end
