defmodule Main do
  @moduledoc """
  Cálculo de consumo de combustible.

  """

   @doc """
    Pide nombre, distancia y combustible, calcula y muestra el rendimiento (km/l).

  """

  def ejercicio1() do
    nombre= Util.input("Ingrese su nombre: ", :string)
    distancia_recorrida= Util.input("Ingrese la distancia recorrida en km: ", :float)
    combustible_consumido= Util.input("Ingrese el combustible consumido en litros: ", :float)
    rendimiento_vehiculo= calcular_rendimiento(distancia_recorrida, combustible_consumido)
    "Hola #{nombre}, el rendimiento de su vehículo es de #{Float.round(rendimiento_vehiculo, 2)} km/l"
    |>Util.show_message()
  end

  @doc """
    calcula el rendimiento en km/l dado distancia y combustible.

  """

  def calcular_rendimiento(distancia, combustible) do
    distancia / combustible
  end
end

Main.ejercicio1()
