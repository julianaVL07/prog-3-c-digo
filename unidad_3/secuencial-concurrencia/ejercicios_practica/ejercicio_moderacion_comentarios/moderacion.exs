defmodule Moderacion do
    @moduledoc """
    Contexto: reglas simples (palabras prohibidas, longitud, links).
    Datos: %Comentario{id, texto}.
    Trabajo: moderar/1 recorre reglas + :timer.sleep(5..12).
    Secuencial vs Concurrente: por comentario.
    Salida: {id, :aprobado | :rechazado}; speedup.

    """

  def moderar_comentario(comentario)do
    texto = String.downcase(comentario.texto)

    prohibidas = ["spam", "oferta", "gratis", "http", "www"]

    # Regla 1: contiene palabras prohibidas
    contiene_prohibidas? =
      Enum.any?(prohibidas, fn palabra ->
        String.contains?(texto, palabra)
      end)

    # Regla 2: longitud muy corta o muy larga
    longitud_invalida? = String.length(texto) < 5 or String.length(texto) > 200

    # Evaluar resultado
    resultado =
      cond do
        contiene_prohibidas? -> :rechazado
        longitud_invalida? -> :rechazado
        true -> :aprobado
      end

    :timer.sleep(Enum.random(5..12))
    {comentario.id, resultado}
  end

  def moderar_comentarios_secuencial(comentarios) do
    Enum.map(comentarios, fn comentario -> moderar_comentario(comentario) end)
  end

  def moderar_comentarios_concurrente(comentarios) do
    Enum.map(comentarios, fn comentario ->
      Task.async(fn -> moderar_comentario(comentario) end)
    end)
    |> Task.await_many()
  end

  def lista_comentarios do
    [
      %Comentario{id: 1, texto: "Me encanta este producto, muy útil!"},
      %Comentario{id: 2, texto: "Esto es malo, no me gusta."},
      %Comentario{id: 3, texto: "Visita http://spam.com para más info."},
      %Comentario{id: 4, texto: "Excelente servicio y atención."},
      %Comentario{id: 5, texto: "feo, no lo recomiendo."},
      %Comentario{id: 6, texto: "Buen precio y calidad."},
      %Comentario{id: 7, texto: "Demora en la entrega, regular."},
      %Comentario{id: 8, texto: "Producto recibido en perfecto estado."},
      %Comentario{id: 9, texto: "No sirve, muy malo."},
      %Comentario{id: 10, texto: "Recomiendo a todos, 100% satisfecho."}
   ]
  end

  # Benchmark
  def run_benchmark(lista_comentarios) do
    tiempos1 =
      Benchmark.determinar_tiempo_ejecucion({__MODULE__, :moderar_comentarios_secuencial, [lista_comentarios]})
    IO.puts("Tiempo de ejecución secuencial: #{tiempos1} microsegundos")

    tiempos2 =
      Benchmark.determinar_tiempo_ejecucion({__MODULE__, :moderar_comentarios_concurrente, [lista_comentarios]})
    IO.puts("Tiempo de ejecución concurrente: #{tiempos2} microsegundos")

    Benchmark.calcular_speedup(tiempos2, tiempos1)
  end


 def iniciar do
  comentarios = lista_comentarios()

  # Secuencial
  moderacion1 = moderar_comentarios_secuencial(comentarios)
  IO.puts("\nModeración comentarios (Secuencial):")
  Enum.each(moderacion1, fn {id, resultado} ->
    IO.puts("  Comentario #{id} - #{resultado}")
  end)

  IO.puts("\n")

  # Concurrente
  moderacion2 = moderar_comentarios_concurrente(comentarios)
  IO.puts("\nModeración comentarios (Concurrente):")
  Enum.each(moderacion2, fn {id, resultado} ->
    IO.puts("  Comentario #{id} - #{resultado}")
  end)

  speed_up = run_benchmark(comentarios)
  IO.puts("\nSpeedup concurrente vs secuencial: #{speed_up}\n")

  IO.puts("\nSimulación terminada.\n")
end
end

Moderacion.iniciar()
