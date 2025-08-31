defmodule Main do
  @moduledoc """
    Control de Inventario de una Librería.

  """

   @doc """
    Solicita el título del libro, cantidad y precio por unidad, calcula y muestra el valor total del inventario.

  """

  def ejercicio2() do
    libro= Util.input("Ingrese el título del libro: ", :string)
    cantidad= Util.input("Ingrese la cantidad de unidades disponibles: ", :integer)
    precio_unidad= Util.input("Ingrese el precio por unidad: ", :float)
    inventario_libro= calcular_inventario_total(cantidad, precio_unidad)
    "EL libro #{libro}, tiene #{cantidad} unidades, con un valor total de $#{round(inventario_libro)}." #cuando es muy grande el número para que no aparezca en exponencial se debe usar round.
    |>Util.show_message()
  end

  @doc """
    Calcula el valor total de inventario dado cantidad y precio por unidad.

  """

  def calcular_inventario_total(cantidad, precio)do
    cantidad * precio
  end

end

Main.ejercicio2()
