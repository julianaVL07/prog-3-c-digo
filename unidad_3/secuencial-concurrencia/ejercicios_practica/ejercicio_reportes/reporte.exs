defmodule Reporte do

  @moduledoc"""
  Contexto: cada sucursal genera su resumen (ventas, top-3 ítems, etc.).
  Datos: %Sucursal{id, ventas_diarias} (lista pequeña).
  Trabajo: reporte(s) comprime datos + :timer.sleep(50..120).
  Secuencial vs Concurrente: una sucursal = un job.
  Salida: imprime “Reporte listo Sucursal X”; speedup.
  """
  def generar_reporte(sucursal) do
    total_ventas_diarias = Enum.sum(sucursal.ventas_diarias)
    promedio = total_ventas_diarias / length(sucursal.ventas_diarias)
    maximo = Enum.max(sucursal.ventas_diarias)

    :timer.sleep(Enum.random(50..120))
    {sucursal.id, %{total: total_ventas_diarias, promedio: promedio, maximo: maximo}}
  end

  def generar_reportes_secuencial(sucursales)do
    Enum.map(sucursales, fn sucursal -> generar_reporte(sucursal) end)
  end

  def generar_reportes_concurrente(sucursales) do
    Enum.map(sucursales, fn sucursal ->
      Task.async(fn -> generar_reporte(sucursal) end)
    end)
    |> Task.await_many()
  end

  def lista_sucursales do
  [
    %Sucursal{id: 1, ventas_diarias: [1200, 950, 800, 1500, 1100]},
    %Sucursal{id: 2, ventas_diarias: [900, 700, 650, 1200, 800]},
    %Sucursal{id: 3, ventas_diarias: [1500, 1300, 1400, 1600, 1700]},
    %Sucursal{id: 4, ventas_diarias: [500, 600, 700, 400, 550]},
    %Sucursal{id: 5, ventas_diarias: [1000, 1100, 1200, 950, 1050]}
  ]
end

 # Benchmark
  def run_benchmark(lista_sucursales) do
    tiempos1 =
      Benchmark.determinar_tiempo_ejecucion({__MODULE__, :generar_reportes_secuencial, [lista_sucursales]})
    IO.puts("Tiempo de ejecución secuencial: #{tiempos1} microsegundos")

    tiempos2 =
      Benchmark.determinar_tiempo_ejecucion({__MODULE__, :generar_reportes_concurrente, [lista_sucursales]})
    IO.puts("Tiempo de ejecución concurrente: #{tiempos2} microsegundos")

    Benchmark.calcular_speedup(tiempos2, tiempos1)
  end

   def iniciar do
    sucursales = lista_sucursales()

    reportes1 = generar_reportes_secuencial(sucursales)
    IO.puts("\nGeneración de reportes SECUENCIAL:")
    Enum.each(reportes1, fn {id, resumen} ->
      IO.puts("Reporte listo Sucursal #{id}. Resumen: #{inspect(resumen)}")
    end)
    IO.puts("\n")

    reportes2 = generar_reportes_concurrente(sucursales)
    IO.puts("\nGeneración de reportes CONCURRENTE:")
    Enum.each(reportes2, fn {id, resumen} ->
      IO.puts("Reporte listo Sucursal #{id}. Resumen: #{inspect(resumen)}")
    end)

    speed_up = run_benchmark(sucursales)
    IO.puts("\nSpeedup concurrente vs secuencial: #{speed_up}\n")

    IO.puts("\nSimulación terminada.\n")
  end
end
Reporte.iniciar()
