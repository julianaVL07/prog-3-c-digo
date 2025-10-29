defmodule SignoNumeros do
  def main do
    lista_numeros = [-10, 25, 0, -7, 3, 0, -1, 8]
    identificar_signo(lista_numeros)
    run_benchmark(lista_numeros)
  end

  # ---- Versión secuencial ----
  def identificar_signo(lista_numeros) do
    Enum.each(lista_numeros, fn numero ->
      IO.puts(identificar_signo_numero(numero))
    end)
  end

  # ---- Versión auxiliar (un solo número) ----
  def identificar_signo_numero(numero) do
    cond do
      numero > 0 -> "#{numero} es positivo"
      numero < 0 -> "#{numero} es negativo"
      true -> "#{numero} es cero"
    end
  end

  # ---- Benchmark ----
  def run_benchmark(lista_numeros) do
    timeResponse =
      Benchmark.determinar_tiempo_ejecucion({__MODULE__, :identificar_signo, [lista_numeros]})
    IO.puts("Tiempo de ejecución secuencial: #{timeResponse} microsegundos")

    timeResponse2 =
      Benchmark.determinar_tiempo_ejecucion({__MODULE__, :run_concurrente, [lista_numeros]})
    IO.puts("Tiempo de ejecución concurrente: #{timeResponse2} microsegundos")
  end

  # ---- Versión concurrente ----
  def run_concurrente(lista_numeros) do
    tareas =
      Enum.map(lista_numeros, fn numero ->
        Task.async(fn -> identificar_signo_numero(numero) end)
      end)

    respuestas =
      Enum.map(tareas, fn tarea ->
        Task.await(tarea)
      end)

    Enum.each(respuestas, fn respuesta ->
      IO.puts(respuesta)
    end)
  end
end

SignoNumeros.main()
