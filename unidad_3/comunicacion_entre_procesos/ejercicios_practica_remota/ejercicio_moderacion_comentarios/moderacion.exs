defmodule Moderacion do
  @moduledoc """
  Contexto: reglas simples (palabras prohibidas, longitud, links).
  Datos: [%Comentario{id, texto}].
  Trabajo: moderar/1 recorre reglas + :timer.sleep(5..12).
  Secuencial vs Concurrente: por comentario.
  Salida: {id, :aprobado | :rechazado}; speedup.
  """

  def moderar_comentario(comentario) do
    texto = String.downcase(comentario.texto)
    prohibidas = ["spam", "oferta", "gratis", "http", "www"]

    contiene_prohibidas? =
      Enum.any?(prohibidas, fn palabra -> String.contains?(texto, palabra) end)

    longitud_invalida? = String.length(texto) < 5 or String.length(texto) > 200

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
    Enum.map(comentarios, &moderar_comentario/1)
  end

  def moderar_comentarios_concurrente(comentarios) do
    Enum.map(comentarios, fn c -> Task.async(fn -> moderar_comentario(c) end) end)
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

  # Benchmark (sin imprimir en consola)
  def run_benchmark(lista_comentarios) do
    tiempos1 =
      Benchmark.determinar_tiempo_ejecucion(
        {_MODULE_, :moderar_comentarios_secuencial, [lista_comentarios]}
      )

    tiempos2 =
      Benchmark.determinar_tiempo_ejecucion(
        {_MODULE_, :moderar_comentarios_concurrente, [lista_comentarios]}
      )

    speedup = Benchmark.calcular_speedup(tiempos2, tiempos1)

    """
    Tiempo secuencial: #{tiempos1} microsegundos
    Tiempo concurrente: #{tiempos2} microsegundos
    Speedup concurrente vs secuencial: #{speedup}
    """
  end

  # Ejecución general — devuelve TODO como texto
  def iniciar do
    comentarios = lista_comentarios()

    sec =
      moderar_comentarios_secuencial(comentarios)
      |> Enum.map_join("\n", fn {id, r} -> "  Comentario #{id} - #{r}" end)

    conc =
      moderar_comentarios_concurrente(comentarios)
      |> Enum.map_join("\n", fn {id, r} -> "  Comentario #{id} - #{r}" end)

    benchmark = run_benchmark(comentarios)

    """
     MODERACIÓN DE COMENTARIOS

    Moderación (Secuencial):
    #{sec}

    Moderación (Concurrente):
    #{conc}

    #{benchmark}
    """
  end
end
