defmodule Dispositivo do

  @moduledoc"""
  S3. Inventario de dispositivos.
  Se define un struct Dispositivo con id, tipo (ej. "laptop", "tablet"), marca, estado (ej. "nuevo", "usado", "dañado").
  Se requiere una función que indique si es apto para préstamo (estado ∈ {"nuevo","usado"}) y otra que actualice el estado.
  """

  defstruct id: "", tipo: "", marca: "", estado: ""

  def crear(id, tipo, marca, estado) do
    %Dispositivo{id: id, tipo: tipo, marca: marca, estado: estado}
  end

  def es_apto_para_prestamo(dispositivo) do
    estado= dispositivo.estado
    if estado == "nuevo" or estado == "usado" do
      true
    else
      false
    end
  end

  def actualizar_estado(dispositivo, nuevo_estado) do
    %Dispositivo{dispositivo | estado: nuevo_estado}
  end
  
end
