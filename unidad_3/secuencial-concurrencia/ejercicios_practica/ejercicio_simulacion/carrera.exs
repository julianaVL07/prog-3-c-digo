defmodule Carrera do
  @moduledoc"""
  Contexto: varios autos corren 3 vueltas con tiempos distintos.
  Datos: %Car{id, piloto, pit_ms, vuelta_ms}.
  Trabajo: simular_carrera(car) hace :timer.sleep/1 por vuelta + pit.
  Secuencial: procesar autos en orden.
  Concurrente: un proceso por auto.
  Salida: ranking con total ms por auto; compara tiempos y speedup.
  """

  @vueltas 3

  # Simula un solo auto
  def simular_carrera(%Car{piloto: piloto, vuelta_ms: vms, pit_ms: pms}) do
    total =
      Enum.reduce(1..@vueltas, 0, fn _, acc ->
        :timer.sleep(vms)
        acc + vms
      end)

    total_total = total + pms
    IO.puts("#{piloto} terminó con #{total_total} ms.")
    {piloto, total_total}
  end

  # Procesa los autos uno por uno (secuencial)
  def carrera_secuencial(autos) do
    Enum.map(autos, &simular_carrera/1)
    |> Enum.sort_by(fn {_piloto, tiempo} -> tiempo end)
  end

    # Un proceso por auto (concurrente)
  def carrera_concurrente(autos) do

    Enum.map(autos, fn auto ->
      Task.async(fn -> simular_carrera(auto) end)
    end)
    |> Task.await_many()
    |> Enum.sort_by(fn {_piloto, tiempo} -> tiempo end)
  end

  def lista_autos do
    [
      %Car{id: 1, piloto: "Hamilton", vuelta_ms: 800, pit_ms: 400},
      %Car{id: 2, piloto: "Verstappen", vuelta_ms: 750, pit_ms: 300},
      %Car{id: 3, piloto: "Alonso", vuelta_ms: 820, pit_ms: 500},
      %Car{id: 4, piloto: "Leclerc", vuelta_ms: 790, pit_ms: 350}
    ]
  end

   # Benchmark
  def run_benchmark(lista_autos) do
    tiempos1 =
      Benchmark.determinar_tiempo_ejecucion({__MODULE__, :carrera_secuencial, [lista_autos]})
    IO.puts("Tiempo de ejecución secuencial: #{tiempos1} microsegundos")

    tiempos2 =
      Benchmark.determinar_tiempo_ejecucion({__MODULE__, :carrera_concurrente, [lista_autos]})
    IO.puts("Tiempo de ejecución concurrente: #{tiempos2} microsegundos")

    Benchmark.calcular_speedup(tiempos2, tiempos1)
  end


  def iniciar do
    autos = lista_autos()


    ranking1 = carrera_secuencial(autos)
    IO.puts("\nRanking SECUENCIAL:")
    Enum.each(ranking1, fn {piloto, tiempo} ->
      IO.puts("  #{piloto} - #{tiempo} ms")
    end)
    IO.puts("\n")

    ranking2 = carrera_concurrente(autos)
    IO.puts("\nRanking CONCURRENTE:")
    Enum.each(ranking2, fn {piloto, tiempo} ->
      IO.puts("  #{piloto} - #{tiempo} ms")
    end)

    speed_up = run_benchmark(autos)
    IO.puts("\nSpeedup concurrente vs secuencial: #{speed_up}\n")

    IO.puts("\nSimulación terminada.\n")
  end
end


Carrera.iniciar()
