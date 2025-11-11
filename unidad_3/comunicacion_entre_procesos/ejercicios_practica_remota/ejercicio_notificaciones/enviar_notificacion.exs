defmodule EnviarNotificacion do
  @moduledoc """
  Contexto: enviar push/email/SMS (sin salir a la red; solo simula delay).
  Datos: %Notificacion{canal, usuario, plantilla}.
  Trabajo: enviar/1 = :timer.sleep(costo_por_canal).
  Secuencial vs Concurrente: por notificación.
  Salida: “Enviada a user X (canal Y)”; speedup.
  """

  def enviar_notificacion(notificacion) do
    costo =
      case notificacion.canal do
        :email -> 100
        :sms -> 200
        :push -> 50
        _ -> 100
      end

    :timer.sleep(costo)
    "Enviada a #{notificacion.usuario} (canal #{notificacion.canal})"
  end

  def enviar_notificacion_secuencial(notificaciones) do
    Enum.map(notificaciones, &enviar_notificacion/1)
  end

  def enviar_notificacion_concurrente(notificaciones) do
    notificaciones
    |> Enum.map(fn notif -> Task.async(fn -> enviar_notificacion(notif) end) end)
    |> Task.await_many()
  end

  def lista_notificaciones do
    [
      %Notificacion{canal: :email, usuario: "ana@example.com", plantilla: "Bienvenida"},
      %Notificacion{canal: :sms, usuario: "3101234567", plantilla: "Código verificación"},
      %Notificacion{canal: :push, usuario: "miguel", plantilla: "Alerta nueva"},
      %Notificacion{canal: :email, usuario: "lina@example.com", plantilla: "Promoción"}
    ]
  end

  # Benchmark
  def run_benchmark(lista_notificaciones) do
    tiempos1 =
      Benchmark.determinar_tiempo_ejecucion(
        {_MODULE_, :enviar_notificacion_secuencial, [lista_notificaciones]}
      )

    tiempos2 =
      Benchmark.determinar_tiempo_ejecucion(
        {_MODULE_, :enviar_notificacion_concurrente, [lista_notificaciones]}
      )

    speedup = Benchmark.calcular_speedup(tiempos2, tiempos1)

    """
    Tiempo secuencial: #{tiempos1} microsegundos
    Tiempo concurrente: #{tiempos2} microsegundos
    Speedup concurrente vs secuencial: #{speedup}
    """
  end

  # Ejecución general (versión que devuelve texto, no imprime)
  def iniciar do
    notificaciones = lista_notificaciones()

    resultados1 =
      enviar_notificacion_secuencial(notificaciones)
      |> Enum.map(&("  " <> &1))
      |> Enum.join("\n")

    resultados2 =
      enviar_notificacion_concurrente(notificaciones)
      |> Enum.map(&("  " <> &1))
      |> Enum.join("\n")

    resumen = run_benchmark(notificaciones)

    """
    Envío de notificaciones (Secuencial):
    #{resultados1}

    Envío de notificaciones (Concurrente):
    #{resultados2}

    #{resumen}
    """
  end
end
