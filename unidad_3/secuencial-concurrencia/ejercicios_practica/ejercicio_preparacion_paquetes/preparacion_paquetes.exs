defmodule PreparacionPaquetes do

    @moduledoc"""
    Contexto: empacar pedidos con pasos: etiquetar, pesar, embalar.
    Datos: %Paquete{id, peso, fragil?}.
    Trabajo: preparar/1 hace 2–3 sleeps según flags.
    Secuencial vs Concurrente: por paquete.
    Salida: {id, listo_en_ms}; speedup.
    """
  def preparar_paquete(paquete) do
    inicio = System.monotonic_time(:millisecond)

    # Paso 1: etiquetar (todos lo hacen)
    :timer.sleep(Enum.random(40..70))

    # Paso 2: pesar (todos lo hacen)
    :timer.sleep(Enum.random(60..100))

    # Paso 3: embalar (solo si es frágil, requiere más cuidado)
    if paquete.fragil? do
      :timer.sleep(Enum.random(100..150))
    else
      :timer.sleep(Enum.random(50..80))
    end

    fin = System.monotonic_time(:millisecond)
    duracion = fin - inicio
    {paquete.id, duracion}
  end


def preparacion_paquetes_secuencial(paquetes) do
    Enum.map(paquetes, fn paquete -> preparar_paquete(paquete) end)
end

def preparacion_paquetes_concurrente(paquetes) do
    Enum.map(paquetes, fn paquete ->
      Task.async(fn -> preparar_paquete(paquete) end)
    end)
    |> Task.await_many()

  end

  def lista_paquetes do
  [
    %Paquete{id: 1, peso: 2.5, fragil?: true},
    %Paquete{id: 2, peso: 1.2, fragil?: false},
    %Paquete{id: 3, peso: 3.8, fragil?: true},
    %Paquete{id: 4, peso: 0.9, fragil?: false},
    %Paquete{id: 5, peso: 5.0, fragil?: true},
    %Paquete{id: 6, peso: 2.0, fragil?: false},
    %Paquete{id: 7, peso: 4.1, fragil?: true},
    %Paquete{id: 8, peso: 1.5, fragil?: false}
  ]
end

# Benchmark
  def run_benchmark(lista_paquetes) do
    tiempos1 =
      Benchmark.determinar_tiempo_ejecucion({__MODULE__, :preparacion_paquetes_secuencial, [lista_paquetes]})
    IO.puts("Tiempo de ejecución secuencial: #{tiempos1} microsegundos")

    tiempos2 =
      Benchmark.determinar_tiempo_ejecucion({__MODULE__, :preparacion_paquetes_concurrente, [lista_paquetes]})
    IO.puts("Tiempo de ejecución concurrente: #{tiempos2} microsegundos")

    Benchmark.calcular_speedup(tiempos2, tiempos1)
  end

  def iniciar do
    paquetes = lista_paquetes()

    preparacion1 = preparacion_paquetes_secuencial(paquetes)
    IO.puts("\npreparación paquetes SECUENCIAL:")
    Enum.each(preparacion1, fn {id, duracion} ->
      IO.puts("paquete #{id} - Duración: #{duracion} ms")
    end)
    IO.puts("\n")

    preparacion2 = preparacion_paquetes_concurrente(paquetes)
    IO.puts("\npreparación paquetes CONCURRENTE:")
    Enum.each(preparacion2, fn {id, duracion} ->
      IO.puts("paquete #{id} - Duración: #{duracion} ms")
    end)

    speed_up = run_benchmark(paquetes)
    IO.puts("\nSpeedup concurrente vs secuencial: #{speed_up}\n")

    IO.puts("\nSimulación terminada.\n")
  end
end
PreparacionPaquetes.iniciar()
