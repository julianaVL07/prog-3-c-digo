defmodule PrepararOrdenes do
  @moduledoc """
  Contexto: preparar órdenes de bebidas/comidas con tiempos distintos.
  Datos: %Orden{id, item, prep_ms}.
  Trabajo: preparar(o) = :timer.sleep(o.prep_ms) y retorna ticket.
  Secuencial vs Concurrente: todas las órdenes.
  Salida: tickets en consola + speedup.
  """

  defmodule Orden do
    defstruct [:id, :item, :prep_ms]
  end

  # Simula la preparación de una sola orden
  def preparar_orden(%Orden{id: id, item: item, prep_ms: prep_ms}) do
    :timer.sleep(prep_ms)
    {id, item, prep_ms}
  end

  # Versión secuencial
  def preparar_ordenes_secuencial(ordenes) do
    Enum.map(ordenes, &preparar_orden/1)
  end

  # Versión concurrente
  def preparar_ordenes_concurrente(ordenes) do
    Enum.map(ordenes, fn orden ->
      Task.async(fn -> preparar_orden(orden) end)
    end)
    |> Task.await_many()
  end

  # Lista base de órdenes
  def lista_ordenes do
    [
      %Orden{id: 1, item: "Café Espresso", prep_ms: 1000},
      %Orden{id: 2, item: "Té Verde", prep_ms: 800},
      %Orden{id: 3, item: "Sándwich de Jamón", prep_ms: 1500},
      %Orden{id: 4, item: "Ensalada Laura", prep_ms: 1200},
      %Orden{id: 5, item: "Jugo de Naranja", prep_ms: 700}
    ]
  end

  # Benchmark: devuelve texto (no imprime directamente)
  def run_benchmark(ordenes) do
    tiempo_seq =
      Benchmark.determinar_tiempo_ejecucion({__MODULE__, :preparar_ordenes_secuencial, [ordenes]})

    tiempo_con =
      Benchmark.determinar_tiempo_ejecucion({__MODULE__, :preparar_ordenes_concurrente, [ordenes]})

    speedup = Benchmark.calcular_speedup(tiempo_con, tiempo_seq)
    speedup_redondeado = Float.round(speedup, 2)

    """
    Tiempo de ejecución secuencial: #{tiempo_seq} microsegundos.
    Tiempo de ejecución concurrente: #{tiempo_con} microsegundos.
    Speedup concurrente vs secuencial: #{speedup_redondeado} 
    """
  end

  def iniciar do
    ordenes = lista_ordenes()
    secuencial = preparar_ordenes_secuencial(ordenes)
    concurrente = preparar_ordenes_concurrente(ordenes)
    benchmark = run_benchmark(ordenes)

    """
     Resultados de la Cafetería

    Preparación SECUENCIAL:
    #{Enum.map_join(secuencial, "\n", fn {id, item, tiempo} ->
      "  Orden ##{id} - #{item} lista en #{tiempo} ms"
    end)}

    \nPreparación CONCURRENTE:
    #{Enum.map_join(concurrente, "\n", fn {id, item, tiempo} ->
      "  Orden ##{id} - #{item} lista en #{tiempo} ms"
    end)}

    \n#{benchmark}
    """
  end
end
