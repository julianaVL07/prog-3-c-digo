defmodule LimpiarResenas do

  @stopwords ["el", "la", "los", "las", "un", "una", "unos", "unas", "y", "o", "pero", "sino",
             "porque", "que", "de", "del", "al", "a", "en", "para", "por", "con", "mi", "tu",
             "su", "este", "esta", "estos", "estas"]
  @moduledoc"""
  Contexto: normalizar reseñas de clientes.
  Datos: [%Review{id, texto}].
  Trabajo: limpiar/1 (downcase, quitar tildes, quitar stopwords) + :timer.sleep(5..15).
  Secuencial vs Concurrente: sobre muchas reseñas.
  Salida: {id, resumen}; speedup.
  """
  def limpiar_resena(resena) do
    texto_limpio =
      resena.texto
      |> String.downcase() # pasa todo a minúsculas
      |> quitar_tildes() # quita tildes
      |> String.split(" ")              # separa por espacios
      |> Enum.reject(fn palabra -> palabra in @stopwords end)  # elimina palabras comunes
      |> Enum.join(" ")                 # vuelve a unir el texto

    :timer.sleep(Enum.random(5..15))    # simula tiempo de limpieza
    {resena.id, texto_limpio}
  end

  defp quitar_tildes(texto) do
    texto
    |> String.replace("á", "a")
    |> String.replace("é", "e")
    |> String.replace("í", "i")
    |> String.replace("ó", "o")
    |> String.replace("ú", "u")
    |> String.replace("ü", "u")
    |> String.replace("ñ", "n")
  end

  def limpiar_resenas_secuencial(resenas) do
    Enum.map(resenas, fn resena -> limpiar_resena(resena) end)
  end

  def limpiar_resenas_concurrente(resenas) do
    Enum.map(resenas, fn resena ->
      Task.async(fn -> limpiar_resena(resena) end)
    end)
    |> Task.await_many()
  end

  def lista_resenas do
  [
    %Resena{id: 1, texto: "¡Excelente producto! Me encantó."},
    %Resena{id: 2, texto: "Regular, no cumplió con mis expectativas."},
    %Resena{id: 3, texto: "Muy bueno, pero el envío tardó demasiado."},
    %Resena{id: 4, texto: "Terrible experiencia, no lo recomiendo."},
    %Resena{id: 5, texto: "Perfecto, lo volvería a comprar sin dudar."},
    %Resena{id: 6, texto: "El producto llegó dañado, mala atención."},
    %Resena{id: 7, texto: "Buen precio y buena calidad, satisfecho."},
    %Resena{id: 8, texto: "No me gustó, esperaba más por el precio."},
    %Resena{id: 9, texto: "Entrega rápida, producto como se describe."},
    %Resena{id: 10, texto: "Muy mala experiencia con la tienda."}
  ]
  end

  # Benchmark
  def run_benchmark(lista_resenas) do
    tiempos1 =
      Benchmark.determinar_tiempo_ejecucion({__MODULE__, :limpiar_resenas_secuencial, [lista_resenas]})
    IO.puts("Tiempo de ejecución secuencial: #{tiempos1} microsegundos")

    tiempos2 =
      Benchmark.determinar_tiempo_ejecucion({__MODULE__, :limpiar_resenas_concurrente, [lista_resenas]})
    IO.puts("Tiempo de ejecución concurrente: #{tiempos2} microsegundos")

    Benchmark.calcular_speedup(tiempos2, tiempos1)
  end

  def iniciar do
    resenas = lista_resenas()

    resenas1 = limpiar_resenas_secuencial(resenas)
    IO.puts("\nReseñas SECUENCIAL:")
    Enum.each(resenas1, fn {id,texto_limpio} ->
      IO.puts("Reseña ##{id}: #{texto_limpio}")
    end)
    IO.puts("\n")

    resenas2 = limpiar_resenas_concurrente(resenas)
    IO.puts("\nReseñas CONCURRENTE:")
    Enum.each(resenas2, fn {id, texto_limpio} ->
      IO.puts("Reseña ##{id}: #{texto_limpio}")
    end)

    speed_up = run_benchmark(resenas)
    IO.puts("\nSpeedup concurrente vs secuencial: #{speed_up}\n")

    IO.puts("\nSimulación terminada.\n")
  end
end
LimpiarResenas.iniciar()
