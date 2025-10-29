defmodule EjemplosConcurrencia do
  @moduledoc """
  3 ejemplos simples de concurrencia vs secuencial en Elixir
  """

  # ============================================
  # EJEMPLO 1: PIZZERÍA
  # ============================================
  defmodule Pizzeria do
    def ejecutar do
      IO.puts("\n🍕 ===== PIZZERÍA ===== 🍕")
      pizzas = ["Margarita", "Pepperoni", "Hawaiana", "Cuatro Quesos"]

      # Secuencial
      IO.puts("\n📦 MODO SECUENCIAL (un horno):")
      inicio = :os.system_time(:millisecond)
      Enum.each(pizzas, &hornear_secuencial/1)
      tiempo_sec = :os.system_time(:millisecond) - inicio
      IO.puts("⏱️  Tiempo total: #{tiempo_sec}ms\n")

      # Concurrente
      IO.puts("⚡ MODO CONCURRENTE (varios hornos):")
      inicio = :os.system_time(:millisecond)

      pizzas
      |> Enum.map(fn pizza ->
        Task.async(fn -> hornear_concurrente(pizza) end)
      end)
      |> Enum.map(&Task.await/1)

      tiempo_conc = :os.system_time(:millisecond) - inicio
      IO.puts("⏱️  Tiempo total: #{tiempo_conc}ms")
      IO.puts("🚀 Mejora: #{Float.round(tiempo_sec / tiempo_conc, 1)}x más rápido\n")
    end

    defp hornear_secuencial(pizza) do
      IO.puts("  🔥 Horneando #{pizza}...")
      Process.sleep(1000)  # Simula 1 segundo de horneado
      IO.puts("  ✅ #{pizza} lista!")
    end

    defp hornear_concurrente(pizza) do
      IO.puts("  🔥 Horneando #{pizza}...")
      Process.sleep(1000)
      IO.puts("  ✅ #{pizza} lista!")
      pizza
    end
  end

  # ============================================
  # EJEMPLO 2: DESCARGA DE ARCHIVOS
  # ============================================
  defmodule Descargas do
    def ejecutar do
      IO.puts("\n💾 ===== DESCARGA DE ARCHIVOS ===== 💾")
      archivos = [
        {"video.mp4", 3},
        {"imagen.jpg", 1},
        {"documento.pdf", 2},
        {"musica.mp3", 2}
      ]

      # Secuencial
      IO.puts("\n📥 MODO SECUENCIAL:")
      inicio = :os.system_time(:millisecond)
      Enum.each(archivos, fn {nombre, tiempo} ->
        descargar_secuencial(nombre, tiempo)
      end)
      tiempo_sec = :os.system_time(:millisecond) - inicio
      IO.puts("⏱️  Tiempo total: #{tiempo_sec}ms\n")

      # Concurrente
      IO.puts("⚡ MODO CONCURRENTE:")
      inicio = :os.system_time(:millisecond)

      archivos
      |> Enum.map(fn {nombre, tiempo} ->
        Task.async(fn -> descargar_concurrente(nombre, tiempo) end)
      end)
      |> Enum.map(&Task.await(&1, 10000))

      tiempo_conc = :os.system_time(:millisecond) - inicio
      IO.puts("⏱️  Tiempo total: #{tiempo_conc}ms")
      IO.puts("🚀 Mejora: #{Float.round(tiempo_sec / tiempo_conc, 1)}x más rápido\n")
    end

    defp descargar_secuencial(nombre, segundos) do
      IO.puts("  📡 Descargando #{nombre}...")
      Process.sleep(segundos * 1000)
      IO.puts("  ✅ #{nombre} descargado (#{segundos}s)")
    end

    defp descargar_concurrente(nombre, segundos) do
      IO.puts("  📡 Descargando #{nombre}...")
      Process.sleep(segundos * 1000)
      IO.puts("  ✅ #{nombre} descargado (#{segundos}s)")
      nombre
    end
  end

  # ============================================
  # EJEMPLO 3: CAJEROS EN UN BANCO
  # ============================================
  defmodule Banco do
    def ejecutar do
      IO.puts("\n🏦 ===== BANCO ===== 🏦")
      clientes = ["Ana", "Carlos", "María", "Pedro", "Lucía"]

      # Secuencial
      IO.puts("\n👤 MODO SECUENCIAL (1 cajero):")
      inicio = :os.system_time(:millisecond)
      Enum.each(clientes, &atender_secuencial/1)
      tiempo_sec = :os.system_time(:millisecond) - inicio
      IO.puts("⏱️  Tiempo total: #{tiempo_sec}ms\n")

      # Concurrente
      IO.puts("⚡ MODO CONCURRENTE (varios cajeros):")
      inicio = :os.system_time(:millisecond)

      clientes
      |> Enum.map(fn cliente ->
        Task.async(fn -> atender_concurrente(cliente) end)
      end)
      |> Enum.map(&Task.await/1)

      tiempo_conc = :os.system_time(:millisecond) - inicio
      IO.puts("⏱️  Tiempo total: #{tiempo_conc}ms")
      IO.puts("🚀 Mejora: #{Float.round(tiempo_sec / tiempo_conc, 1)}x más rápido\n")
    end

    defp atender_secuencial(cliente) do
      tiempo = 800 + :rand.uniform(400)  # Entre 800-1200ms
      IO.puts("  💼 Atendiendo a #{cliente}...")
      Process.sleep(tiempo)
      IO.puts("  ✅ #{cliente} atendido (#{tiempo}ms)")
    end

    defp atender_concurrente(cliente) do
      tiempo = 800 + :rand.uniform(400)
      IO.puts("  💼 Atendiendo a #{cliente}...")
      Process.sleep(tiempo)
      IO.puts("  ✅ #{cliente} atendido (#{tiempo}ms)")
      cliente
    end
  end

  # ============================================
  # EJECUTAR TODOS LOS EJEMPLOS
  # ============================================
  def ejecutar_todos do
    IO.puts("\n" <> String.duplicate("=", 50))
    IO.puts("EJEMPLOS DE CONCURRENCIA EN ELIXIR")
    IO.puts(String.duplicate("=", 50))

    Pizzeria.ejecutar()
    Process.sleep(500)

    Descargas.ejecutar()
    Process.sleep(500)

    Banco.ejecutar()

    IO.puts("\n" <> String.duplicate("=", 50))
    IO.puts("✨ Conclusión: La concurrencia permite hacer")
    IO.puts("   múltiples tareas al mismo tiempo,")
    IO.puts("   reduciendo el tiempo total de espera.")
    IO.puts(String.duplicate("=", 50) <> "\n")
  end
end

# Ejecutar todos los ejemplos
EjemplosConcurrencia.ejecutar_todos()
