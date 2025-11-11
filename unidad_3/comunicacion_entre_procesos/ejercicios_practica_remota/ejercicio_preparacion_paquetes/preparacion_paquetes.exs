defmodule PreparacionPaquetes do
  @moduledoc """
  Contexto: empacar pedidos con pasos: etiquetar, pesar, embalar.
  Datos: %Paquete{id, peso, fragil?}.
  Trabajo: preparar/1 hace 2–3 sleeps según flags.
  Secuencial vs Concurrente: por paquete.
  Salida: {id, listo_en_ms}; speedup.
  """

  defmodule Paquete do
    defstruct [:id, :peso, :fragil?]
  end

  def preparar_paquete(paquete) do
    inicio = System.monotonic_time(:millisecond)

    # Paso 1: etiquetar
    :timer.sleep(Enum.random(40..70))
    # Paso 2: pesar
    :timer.sleep(Enum.random(60..100))
    # Paso 3: embalar (varía si es frágil)
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
    Enum.map(paquetes, &preparar_paquete/1)
  end

  def preparacion_paquetes_concurrente(paquetes) do
    paquetes
    |> Enum.map(fn p -> Task.async(fn -> preparar_paquete(p) end) end)
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

  def run_benchmark(lista_paquetes) do
    tiempo1 = Benchmark.determinar_tiempo_ejecucion({_MODULE_, :preparacion_paquetes_secuencial, [lista_paquetes]})
    tiempo2 = Benchmark.determinar_tiempo_ejecucion({_MODULE_, :preparacion_paquetes_concurrente, [lista_paquetes]})
    speedup = Benchmark.calcular_speedup(tiempo2, tiempo1)

    """
    Tiempo secuencial: #{tiempo1} microsegundos
    Tiempo concurrente: #{tiempo2} microsegundos
    Speedup concurrente vs secuencial: #{speedup}
    """
  end

  def iniciar do
    paquetes = lista_paquetes()

    secuencial =
      preparacion_paquetes_secuencial(paquetes)
      |> Enum.map(fn {id, duracion} -> "  paquete #{id} - Duración: #{duracion} ms" end)
      |> Enum.join("\n")

    concurrente =
      preparacion_paquetes_concurrente(paquetes)
      |> Enum.map(fn {id, duracion} -> "  paquete #{id} - Duración: #{duracion} ms" end)
      |> Enum.join("\n")

    resumen = run_benchmark(paquetes)

    """
    preparación paquetes SECUENCIAL:
    #{secuencial}

    preparación paquetes CONCURRENTE:
    #{concurrente}

    #{resumen}
    Simulación terminada.
    """
  end
end
