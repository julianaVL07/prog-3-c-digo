defmodule Mantenimiento do
  @moduledoc """
  Contexto: tareas de mantenimiento: “reindex”, “purga caché”, “generar sitemap”.
  Datos: [:reindex, :purge_cache, :build_sitemap, ...].
  Trabajo: ejecutar(tarea) con case + :timer.sleep/1 distinto por tarea.
  Secuencial vs Concurrente: ejecutar lote diario.
  Salida: “OK tarea X”; speedup.
  """

  # --- Ejecución de una sola tarea ---
  def ejecutar_tarea(tarea) do
    # Dependiendo del tipo de tarea, el tiempo cambia
    case tarea do
      :reindex ->
        :timer.sleep(Enum.random(100..200))
        {:ok, "Reindex completado"}

      :purge_cache ->
        :timer.sleep(Enum.random(50..100))
        {:ok, "Purga de caché completada"}

      :build_sitemap ->
        :timer.sleep(Enum.random(80..150))
        {:ok, "Sitemap generado"}

      _ ->
        :timer.sleep(Enum.random(30..60))
        {:ok, "Tarea desconocida ejecutada"}
    end
  end

  # --- Modo secuencial ---
  def ejecutar_tareas_secuencial(tareas) do
    Enum.map(tareas, fn tarea ->
      {tarea, ejecutar_tarea(tarea)}
    end)
  end

  # --- Modo concurrente ---
  def ejecutar_tareas_concurrente(tareas) do
    Enum.map(tareas, fn tarea ->
      Task.async(fn -> {tarea, ejecutar_tarea(tarea)} end)
    end)
    |> Task.await_many()
  end

  # --- Lista de tareas simuladas ---
  def lista_tareas do
    [:reindex, :purge_cache, :build_sitemap, :backup_db, :optimize_images]
  end

  # --- Benchmark ---
  def run_benchmark(lista_tareas) do
    tiempos1 =
      Benchmark.determinar_tiempo_ejecucion({__MODULE__, :ejecutar_tareas_secuencial, [lista_tareas]})
    IO.puts("Tiempo de ejecución secuencial: #{tiempos1} microsegundos")

    tiempos2 =
      Benchmark.determinar_tiempo_ejecucion({__MODULE__, :ejecutar_tareas_concurrente, [lista_tareas]})
    IO.puts("Tiempo de ejecución concurrente: #{tiempos2} microsegundos")

    Benchmark.calcular_speedup(tiempos2, tiempos1)
  end

  # --- Simulación principal ---
  def iniciar do
    tareas = lista_tareas()

    IO.puts("\nEjecución tareas SECUENCIAL:")
    resultados1 = ejecutar_tareas_secuencial(tareas)
    Enum.each(resultados1, fn {tarea, {:ok, mensaje}} ->
      IO.puts("OK tarea #{tarea}: #{mensaje}")
    end)

    IO.puts("\nEjecución tareas CONCURRENTE:")
    resultados2 = ejecutar_tareas_concurrente(tareas)
    Enum.each(resultados2, fn {tarea, {:ok, mensaje}} ->
      IO.puts("OK tarea #{tarea}: #{mensaje}")
    end)

    speedup = run_benchmark(tareas)
    IO.puts("\nSpeedup concurrente vs secuencial: #{speedup}\n")

    IO.puts("\nSimulación terminada.\n")
  end
end

Mantenimiento.iniciar()
