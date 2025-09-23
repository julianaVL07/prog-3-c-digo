defmodule Main do
  @moduledoc """
    Conversión de Unidades de Temperatura.

  """

   @doc """
   Solicita el nombre del usuario y una temperatura en Celsius, luego muestra la temperatura convertida a Fahrenheit y Kelvin.

  """

  def ejercicio3() do
    nombre= Util.input("Ingrese su nombre: ", :string)
    temperatura_celsius= Util.input("Ingrese la temperatura en Celcius (C°): ", :float)
    conversion_fahrenheit=convertir_fahrenheit(temperatura_celsius)
    conversion_kelvin=convertir_kelvin(temperatura_celsius)
    "#{nombre}, la temperatura es:
    \n -#{Float.round(conversion_fahrenheit, 1)} F°
    \n -#{Float.round(conversion_kelvin, 1)} K°"
    |>Util.show_message()
  end

  @doc """
    Convierte la temperatura de Celsius a Fahrenheit.

  """

  def convertir_fahrenheit(temperatura_celsius)do
    (temperatura_celsius * 9 / 5) + 32
  end

  @doc """
    Convierte la temperatura de Celsius a Kelvin.

  """

  def convertir_kelvin(temperatura_celsius)do
    temperatura_celsius + 273.15
  end

end

Main.ejercicio3()
