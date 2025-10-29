defmodule Usuario do
  @moduledoc"""
  RS2. Filtrado por dominio con recursión.
  Definir %Usuario{ id, correo }. Se solicita una función recursiva que filtre usuarios
  cuyo correo termine en @uq.edu.co, sin usar Enum.filter/2. Debe retornar la lista de %Usuario{} válidos.
  """
  defstruct id: "", correo: ""

  def crear(id, correo) do
    %Usuario{id: id, correo: correo}
  end

  #Caso base
  def filtrar_usuarios([]) do
    []
  end

  def filtrar_usuarios([cabeza| cola]) do
    correo= cabeza.correo
    if String.ends_with?(correo,"@uq.edu.co") do
      [cabeza| filtrar_usuarios(cola)]
    else
      filtrar_usuarios(cola)
    end
  end

end
