defmodule Main do
  @moduledoc"""
    Cálculo del Costo de Envío de un Paquete.

  """

   @doc """
   Solicita el nombre del cliente, peso y tipo de envío, luego calcula y muestra según el tipo y peso la tarifa de envío.

  """

  def ejercicio6() do
    nombre_cliente= Util.input("Ingrese el nombre del cliente: ", :string)
    peso_paquete= Util.input("Ingrese el peso del paquete en kg: ", :float)
    tipo_envio= Util.input("Ingrese el tipo de envío (Económico, Express, Internacional): ", :string)
    |> String.downcase()
    {cliente,peso,tipo,tarifa_envio}= calcular_tarifa_envio(nombre_cliente,peso_paquete,tipo_envio)
    #{cliente,peso,tipo,tarifa_envio}= calcular_tarifa_envio_cond(nombre_cliente,peso_paquete,tipo_envio)
    #{cliente,peso,tipo,tarifa_envio}= calcular_tarifa_envio_case(nombre_cliente,peso_paquete,tipo_envio)
    "Hola #{cliente}, el costo de envío para un paquete de #{peso} kg por (#{tipo}) es de #{round(tarifa_envio)}."
    |>Util.show_message()
  end

  @doc """
  Calcula la tarifa de envío según el tipo y peso del paquete usando if.

  """

  def calcular_tarifa_envio(cliente,peso,tipo)do
    tarifa_envio=
      if tipo== "economico" do
        5000*peso
      else
        if tipo=="express" do
          8000*peso
      else
          if tipo=="internacional" do
            if peso<=5 do
            15000*peso
            else
            12000*peso
            end
          else
          0
          end
        end
      end
      {cliente,peso,tipo,tarifa_envio}
  end

  @doc """
    Calcula la tarifa de envío según el tipo y peso del paquete usando cond.

  """

   def calcular_tarifa_envio_cond(cliente, peso, tipo) do
    tarifa_envio =
      cond do
        tipo == "economico" -> 5000 * peso
        tipo == "express" -> 8000 * peso
        tipo == "internacional" and peso <= 5 -> 15000 * peso
        tipo == "internacional" and peso > 5 -> 12000 * peso
        true -> 0
      end

    {cliente, peso, tipo, tarifa_envio}
  end

  @doc """
    Calcula la tarifa de envío según el tipo y peso del paquete usando case con pattern matching.

  """

  def calcular_tarifa_envio_case(cliente, peso, tipo) do
  tarifa_envio =
    case {tipo, peso} do
      {"economico", p} -> 5000 * p
      {"express", p} -> 8000 * p
      {"internacional", p} when p <= 5 -> 15000 * p
      {"internacional", p} when p > 5 -> 12000 * p
      _ -> 0   # patrón comodín: cualquier otro valor.
    end

  {cliente, peso, tipo, tarifa_envio}
end

end



Main.ejercicio6()
