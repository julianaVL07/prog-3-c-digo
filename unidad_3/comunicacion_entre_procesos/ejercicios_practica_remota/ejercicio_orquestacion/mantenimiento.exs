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

      :backup_db ->
        :timer.sleep(Enum.random(150..250))
        {:ok, "Backup de base de datos completado"}

      :optimize_images ->
        :timer.sleep(Enum.random(70..120))
        {:ok, "Imágenes optimizadas"}

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
    tareas
    |> Enum.map(fn tarea -> Task.async(fn -> {tarea, ejecutar_tarea(tarea)} end) end)
    |> Task.await_many()
  end

  # --- Lista de tareas simuladas ---
  def lista_tareas do
    [:reindex, :purge_cache, :build_sitemap, :backup_db, :optimize_images]
  end

  # --- Benchmark ---
  def run_benchmark(lista_tareas) do
    tiempos1 =
      Benchmark.determinar_tiempo_ejecucion(
        {_MODULE_, :ejecutar_tareas_secuencial, [lista_tareas]}
      )

    tiempos2 =
      Benchmark.determinar_tiempo_ejecucion(
        {_MODULE_, :ejecutar_tareas_concurrente, [lista_tareas]}
      )

    speedup = Benchmark.calcular_speedup(tiempos2, tiempos1)

    """
    Tiempo de ejecución secuencial: #{tiempos1} microsegundos
    Tiempo de ejecución concurrente: #{tiempos2} microsegundos
    Speedup concurrente vs secuencial: #{speedup}
    """
  end

  # --- Simulación principal (devuelve texto, no imprime) ---
  def iniciar do
    tareas = lista_tareas()

    resultados1 =
      ejecutar_tareas_secuencial(tareas)
      |> Enum.map(fn {tarea, {:ok, mensaje}} ->
        "  OK tarea #{tarea}: #{mensaje}"
      end)
      |> Enum.join("\n")

    resultados2 =
      ejecutar_tareas_concurrente(tareas)
      |> Enum.map(fn {tarea, {:ok, mensaje}} ->
        "  OK tarea #{tarea}: #{mensaje}"
      end)
      |> Enum.join("\n")

    resumen = run_benchmark(tareas)

    """
    Ejecución tareas SECUENCIAL:
    #{resultados1}

    Ejecución tareas CONCURRENTE:
    #{resultados2}

    #{resumen}
    """
  end
end
