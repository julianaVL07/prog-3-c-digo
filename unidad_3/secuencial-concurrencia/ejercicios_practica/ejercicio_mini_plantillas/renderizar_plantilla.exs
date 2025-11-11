defmodule RenderizarPlantilla do
  @moduledoc """
  Contexto: renderizar plantillas pequeñas (strings) con variables.
  Datos: %Tpl{id, nombre, vars}.
  Trabajo: render/1 hace String.replace + “costo” con sleep según tamaño.
  Secuencial vs Concurrente: por plantilla.
  Salida: {id, string}; speedup.
  """

  # --- Renderizar una plantilla con variables ---
  def renderizar_plantilla(tpl) do
    base = "Bienvenido, {{nombre}}. Tu pedido es: {{pedido}}. Total: {{total}}."

    # Reemplazar variables (nombre, pedido, total, etc.)
    texto =
      Enum.reduce(tpl.vars, base, fn {clave, valor}, acc ->
        String.replace(acc, "{{#{clave}}}", to_string(valor))
      end)

    # Simular tiempo de render según tamaño del texto
    tiempo_ms = String.length(texto)
    :timer.sleep(rem(tiempo_ms, 50) + 10)

    {tpl.id, texto}
  end


  def renderizar_plantillas_secuencial(plantillas) do
    Enum.map(plantillas, fn tpl -> renderizar_plantilla(tpl) end)
  end


  def renderizar_plantillas_concurrente(plantillas) do
    Enum.map(plantillas, fn tpl ->
      Task.async(fn -> renderizar_plantilla(tpl) end)
    end)
    |> Task.await_many()
  end


  def lista_plantillas do
    [
      %Tpl{id: 1, nombre: "plantilla1", vars: %{nombre: "Laura", pedido: "Café", total: "$5000"}},
      %Tpl{id: 2, nombre: "plantilla2", vars: %{nombre: "Ana", pedido: "Té Verde", total: "$4000"}},
      %Tpl{id: 3, nombre: "plantilla3", vars: %{nombre: "Sara", pedido: "Sandwich", total: "$7000"}}
    ]
  end

  # Benchmark
  def run_benchmark(lista_plantillas) do
    tiempos1 =
      Benchmark.determinar_tiempo_ejecucion({__MODULE__, :renderizar_plantillas_secuencial, [lista_plantillas]})
    IO.puts("Tiempo de ejecución secuencial: #{tiempos1} microsegundos")

    tiempos2 =
      Benchmark.determinar_tiempo_ejecucion({__MODULE__, :renderizar_plantillas_concurrente, [lista_plantillas]})
    IO.puts("Tiempo de ejecución concurrente: #{tiempos2} microsegundos")

    Benchmark.calcular_speedup(tiempos2, tiempos1)
  end


  def iniciar do
    plantillas = lista_plantillas()

    IO.puts("\nRenderizado SECUENCIAL:")
    resultado1 = renderizar_plantillas_secuencial(plantillas)
    Enum.each(resultado1, fn {id, texto} ->
      IO.puts("Plantilla ##{id}: #{texto}")
    end)

    IO.puts("\nRenderizado CONCURRENTE:")
    resultado2 = renderizar_plantillas_concurrente(plantillas)
    Enum.each(resultado2, fn {id, texto} ->
      IO.puts("Plantilla ##{id}: #{texto}")
    end)

     speed_up = run_benchmark(plantillas)
    IO.puts("\nSpeedup concurrente vs secuencial: #{speed_up}\n")

    IO.puts("\nSimulación terminada.\n")
  end
end

RenderizarPlantilla.iniciar()
