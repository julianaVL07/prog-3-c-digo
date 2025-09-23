defmodule Main do
  def main do
    list_reservas=list_reservas()
    IO.inspect(list_reservas)
    total_dias_reservados=calcular_dias_reservados(list_reservas)
    IO.puts("\nTotal días reservados: #{total_dias_reservados}")
    list_reserva_mas_5_dias=primera_reserva_mas_5_dias(list_reservas)
    IO.puts("\nPrimera reserva más de 5 días: ")
    IO.inspect(list_reserva_mas_5_dias)
    # {tupla, cliente}=convertir_primera_reserva_tupla(list_reserva_mas_5_dias)
    # IO.puts("\nReserva convertida a tupla y cliente de esa reserva: \n#{inspect(tupla)}\n#{cliente}")
    cliente=convertir_primera_reserva_tupla(list_reserva_mas_5_dias)
    IO.puts("\nnombre del cliente: #{cliente}")

  end

  #Se tiene una lista de reservas, donde cada reserva es un mapa con claves :cliente,
  #:habitacion y :dias. Crear tres reservas

  def list_reservas() do
    [
      %{cliente: "Jhon", habitación: 201, dias: 10},
       %{cliente: "Anrey", habitación: 191, dias: 3},
        %{cliente: "Juli", habitación: 98, dias: 15}
    ]
  end

  #Usar Enum.reduce/3 para calcular el total de días reservados.

  def calcular_dias_reservados(list_reservas) do
    Enum.reduce(list_reservas, 0, fn reserva, acc -> acc + reserva.dias end)
  end

  #Usar Enum.find/2 para obtener la primera reserva que tenga más de 5 días.

  def primera_reserva_mas_5_dias(list_reservas) do
    Enum.find(list_reservas, fn reserva -> reserva.dias > 5 end)
  end

  #Convertir la primera reserva en una tupla y mostrar el nombre del cliente.

  def convertir_primera_reserva_tupla(list_reserva_mas_5_dias) do
    # tupla= Map.to_list(list_reserva_mas_5_dias) #Convierte el mapa de la reserva en una lista de tuplas.
    # |>List.to_tuple()#Convierte esa lista en una tupla de tuplas

    list_tuplas=Enum.into(list_reserva_mas_5_dias, [])
    tupla= List.to_tuple(list_tuplas)

    # Obtener nombre del cliente

    cliente= elem(elem(tupla, 0), 1)

    #{tupla, cliente}
  end
end
Main.main()
