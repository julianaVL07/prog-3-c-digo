defmodule PrepararOrdenes do
  @moduledoc"""
  Contexto: preparar órdenes de bebidas/comidas con tiempos distintos.
  Datos: %Orden{id, item, prep_ms}.
  Trabajo: preparar(o) = :timer.sleep(o.prep_ms) y retorna ticket.
  Secuencial vs Concurrente: todas las órdenes.
  Salida: tickets en consola; speedup.
  """

  def preparar_orden(orden) do
    :timer.sleep(orden.prep_ms)
    {orden.id, orden.item, orden.prep_ms}
  end

  def preparar_ordenes_secuencial(ordenes) do
    Enum.map(ordenes, fn orden -> preparar_orden(orden) end)
  end

  def preparar_ordenes_concurrente(ordenes) do
    Enum.map(ordenes, fn orden ->
      Task.async(fn -> preparar_orden(orden) end)
    end)
    |> Task.await_many()
  end

  def lista_ordenes do
    [
      %Orden{id: 1, item: "Café Espresso", prep_ms: 1000},
      %Orden{id: 2, item: "Té Verde", prep_ms: 800},
      %Orden{id: 3, item: "Sándwich de Jamón", prep_ms: 1500},
      %Orden{id: 4, item: "Ensalada Laura", prep_ms: 1200},
      %Orden{id: 5, item: "Jugo de Naranja", prep_ms: 700}
    ]
  end

  # Benchmark
  def run_benchmark(lista_ordenes) do
    tiempos1 =
      Benchmark.determinar_tiempo_ejecucion({__MODULE__, :preparar_ordenes_secuencial, [lista_ordenes]})
    IO.puts("Tiempo de ejecución secuencial: #{tiempos1} microsegundos")

    tiempos2 =
      Benchmark.determinar_tiempo_ejecucion({__MODULE__, :preparar_ordenes_concurrente, [lista_ordenes]})
    IO.puts("Tiempo de ejecución concurrente: #{tiempos2} microsegundos")

    Benchmark.calcular_speedup(tiempos2, tiempos1)
  end

  def iniciar do
    ordenes = lista_ordenes()

    preparacion1 = preparar_ordenes_secuencial(ordenes)
    IO.puts("\nPreparacion SECUENCIAL:")
    Enum.each(preparacion1, fn {id, item, tiempo} ->
      IO.puts("Orden ##{id} de #{item} lista en #{tiempo} ms")
    end)
    IO.puts("\n")

    preparacion2 = preparar_ordenes_concurrente(ordenes)
    IO.puts("\nPreparacion CONCURRENTE:")
    Enum.each(preparacion2, fn {id, item, tiempo} ->
      IO.puts("Orden ##{id} de #{item} lista en #{tiempo} ms")
    end)

    speed_up = run_benchmark(ordenes)
    IO.puts("\nSpeedup concurrente vs secuencial: #{speed_up}\n")

    IO.puts("\nSimulación terminada.\n")
  end
end

PrepararOrdenes.iniciar()
