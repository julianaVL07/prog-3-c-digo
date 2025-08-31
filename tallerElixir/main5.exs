defmodule Main do
  @moduledoc"""
    Registro de Vehículos en un Peaje.

  """

   @doc """
    Solicita la placa del vehículo, tipo y peso, calcula y muestra la tarifa a pagar según el tipo de vehículo.

  """

  def ejercicio5() do
    placa= Util.input("Ingrese la placa del vehículo: ", :string)
    tipo_vehiculo= Util.input("Ingrese el tipo de vehículo (Carro,Moto,Camión): ", :string)
    |> String.downcase()
    peso_vehiculo= Util.input("Ingrese el peso de vehículos en toneladas: ", :float)
    {placa, tipo_vehiculo,tarifa}= calcular_tarifa_tipo(placa,tipo_vehiculo,peso_vehiculo) #tupla.
    "Vehículo #{placa} (#{tipo_vehiculo}) debe pagar $#{tarifa}"
    |>Util.show_message()
  end

  @doc """
    Calcula la tarifa a pagar según el tipo de vehículo y su peso (para el camión).

  """

  def calcular_tarifa_tipo(placa,tipo_vehiculo,peso_vehiculo)do
    tarifa=
    if tipo_vehiculo=="carro" do
    10000
  else
     if tipo_vehiculo=="moto" do
    5000
  else
     if tipo_vehiculo=="camion" do
    20000+round(peso_vehiculo*2000)
     else
       0
     end
    end
  end
  {placa, tipo_vehiculo, tarifa} #devuelve una tupla.
end

end

Main.ejercicio5()
