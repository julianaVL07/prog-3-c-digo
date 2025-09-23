defmodule ReservasHotel do
  @moduledoc """
  Reservas de hotel (sumar días)
  Un hotel guarda las reservas en una lista de mapas con claves :cliente y :dias.
  Implementar una función recursiva que calcule el total de días reservados.
  """

  def main do
    reservas = [
      %{cliente: "Tatiana Gonzalez", dias: 5},
      %{cliente: "Tomas Torres", dias: 3},
      %{cliente: "Laura Ruiz", dias: 7}
    ]
    total = total_dias_reservados(reservas) #Recursión directa, lineal y no de cola.
    IO.puts("El total de días reservados por todos los clientes es: #{total}")
  end

  # Caso base: lista vacía
  def total_dias_reservados([]), do: 0

  # Caso recursivo: suma los días del primer cliente con el resto
  def total_dias_reservados([h | t]) do
    h.dias + total_dias_reservados(t)
  end
end

ReservasHotel.main()
