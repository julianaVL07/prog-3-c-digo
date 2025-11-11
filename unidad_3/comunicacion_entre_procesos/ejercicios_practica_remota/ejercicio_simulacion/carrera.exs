defmodule Carrera do
  @moduledoc """
  Contexto: varios autos corren 3 vueltas con tiempos distintos.
  Datos: %Car{id, piloto, pit_ms, vuelta_ms}.
  Trabajo: simular_carrera(car) hace :timer.sleep/1 por vuelta + pit.
  Secuencial: procesa autos en orden.
  Concurrente: un proceso por auto.
  Salida: ranking + speedup.
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
    {piloto, total_total}
  end

  # Carrera secuencial
  def carrera_secuencial(autos) do
    Enum.map(autos, &simular_carrera/1)
    |> Enum.sort_by(fn {_p, t} -> t end)
  end

  # Carrera concurrente
  def carrera_concurrente(autos) do
    Enum.map(autos, fn auto ->
      Task.async(fn -> simular_carrera(auto) end)
    end)
    |> Task.await_many()
    |> Enum.sort_by(fn {_p, t} -> t end)
  end

  # Lista base de autos
  def lista_autos do
    [
      %Car{id: 1, piloto: "Hamilton", vuelta_ms: 800, pit_ms: 400},
      %Car{id: 2, piloto: "Verstappen", vuelta_ms: 750, pit_ms: 300},
      %Car{id: 3, piloto: "Alonso", vuelta_ms: 820, pit_ms: 500},
      %Car{id: 4, piloto: "Leclerc", vuelta_ms: 790, pit_ms: 350}
    ]
  end

  # Benchmark: devuelve un bloque de texto
  def run_benchmark(autos) do
    tiempo_seq =
      Benchmark.determinar_tiempo_ejecucion({__MODULE__, :carrera_secuencial, [autos]})

    tiempo_con =
      Benchmark.determinar_tiempo_ejecucion({__MODULE__, :carrera_concurrente, [autos]})

    # Cálculo correcto del speedup (secuencial / concurrente)
    speedup = Benchmark.calcular_speedup(tiempo_con, tiempo_seq)
    speedup_redondeado = Float.round(speedup, 2)

    """
    Tiempo de ejecución secuencial: #{tiempo_seq} microsegundos.
    Tiempo de ejecución concurrente: #{tiempo_con} microsegundos.
    Speedup concurrente vs secuencial: #{speedup_redondeado}
    """
  end

  # Devuelve el texto final de la simulación
  def iniciar do
    autos = lista_autos()
    ranking1 = carrera_secuencial(autos)
    ranking2 = carrera_concurrente(autos)
    benchmark = run_benchmark(autos)

    """
    Resultados de la Carrera

    Ranking SECUENCIAL:
    #{Enum.map_join(ranking1, "\n", fn {p, t} -> "  #{p} - #{t} ms" end)}

    \nRanking CONCURRENTE:
    #{Enum.map_join(ranking2, "\n", fn {p, t} -> "  #{p} - #{t} ms" end)}

    \n#{benchmark}

    Simulación terminada en el servidor.
    """
  end
end
