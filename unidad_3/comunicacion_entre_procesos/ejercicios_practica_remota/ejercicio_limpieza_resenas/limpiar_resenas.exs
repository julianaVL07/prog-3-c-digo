defmodule LimpiarResenas do
  @moduledoc """
  Contexto: normalizar reseñas de clientes.
  Datos: [%Resena{id, texto}].
  Trabajo: limpiar/1 (downcase, quitar tildes, quitar stopwords) + :timer.sleep(5..15).
  Secuencial vs Concurrente: sobre muchas reseñas.
  Salida: {id, resumen}; speedup.
  """

  @stopwords ["el", "la", "los", "las", "un", "una", "unos", "unas", "y", "o", "pero", "sino",
             "porque", "que", "de", "del", "al", "a", "en", "para", "por", "con", "mi", "tu",
             "su", "este", "esta", "estos", "estas"]

  def limpiar_resena(resena) do
    texto_limpio =
      resena.texto
      |> String.downcase()
      |> quitar_tildes()
      |> String.split(" ")
      |> Enum.reject(fn palabra -> palabra in @stopwords end)
      |> Enum.join(" ")

    :timer.sleep(Enum.random(5..15))
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
    Enum.map(resenas, &limpiar_resena/1)
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

  def run_benchmark(lista_resenas) do
    tiempo_seq =
      Benchmark.determinar_tiempo_ejecucion({_MODULE_, :limpiar_resenas_secuencial, [lista_resenas]})
    tiempo_con =
      Benchmark.determinar_tiempo_ejecucion({_MODULE_, :limpiar_resenas_concurrente, [lista_resenas]})

    speedup = Benchmark.calcular_speedup(tiempo_con, tiempo_seq)

    """
    Tiempo de ejecución secuencial: #{tiempo_seq} microsegundos.
    Tiempo de ejecución concurrente: #{tiempo_con} microsegundos.
    Speedup concurrente vs secuencial: #{Float.round(speedup, 2)}
    """
  end

  def iniciar do
    resenas = lista_resenas()

    secuencial =
      Enum.map_join(limpiar_resenas_secuencial(resenas), "\n", fn {id, texto} ->
        "Reseña ##{id}: #{texto}"
      end)

    concurrente =
      Enum.map_join(limpiar_resenas_concurrente(resenas), "\n", fn {id, texto} ->
        "Reseña ##{id}: #{texto}"
      end)

    benchmark = run_benchmark(resenas)

    """
     Resultados de la Limpieza de Reseñas

    --- LIMPIEZA SECUENCIAL ---
    #{secuencial}

    --- LIMPIEZA CONCURRENTE ---
    #{concurrente}

    #{benchmark}

    Limpieza completada en el servidor.
    """
  end
end
