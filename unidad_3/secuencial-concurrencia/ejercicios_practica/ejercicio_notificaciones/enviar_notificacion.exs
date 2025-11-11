defmodule EnviarNotificacion do
  @moduledoc"""
  Contexto: enviar push/email/SMS (sin salir a la red; solo simula delay).
  Datos: %Notif{canal, usuario, plantilla}.
  Trabajo: enviar/1 = :timer.sleep(costo_por_canal).
  Secuencial vs Concurrente: por notificación.
  Salida: “Enviada a user X (canal Y)”; speedup.
  """
  def enviar_notificacion(notificacion)do
    costo =
        case notificacion.canal do
          :email -> 100
          :sms   -> 200
          :push  -> 50
          _      -> 100
        end
      :timer.sleep(costo)
  end

  def enviar_notificacion_secuencial(notificaciones) do
    Enum.map(notificaciones, fn notificacion -> enviar_notificacion(notificacion) end)
  end

  def enviar_notificacion_concurrente(notificaciones) do
    Enum.map(notificaciones, fn notificacion ->
      Task.async(fn -> enviar_notificacion(notificacion) end)
    end)
    |> Task.await_many()
  end

   def lista_notificaciones do
    [
      %Notificacion{canal: "email", usuario: "ana@example.com", plantilla: "Bienvenida"},
      %Notificacion{canal: "sms", usuario: "3101234567", plantilla: "Código verificación"},
      %Notificacion{canal: "push", usuario: "miguel", plantilla: "Alerta nueva"},
      %Notificacion{canal: "email", usuario: "lina@example.com", plantilla: "Promoción"}
    ]
  end

   # Benchmark
  def run_benchmark(lista_notificaciones) do
    tiempos1 =
      Benchmark.determinar_tiempo_ejecucion({__MODULE__, :enviar_notificacion_secuencial, [lista_notificaciones]})
    IO.puts("Tiempo de ejecución secuencial: #{tiempos1} microsegundos")

    tiempos2 =
      Benchmark.determinar_tiempo_ejecucion({__MODULE__, :enviar_notificacion_concurrente, [lista_notificaciones]})
    IO.puts("Tiempo de ejecución concurrente: #{tiempos2} microsegundos")

    Benchmark.calcular_speedup(tiempos2, tiempos1)
  end

   def iniciar do
    notificaciones = lista_notificaciones()

    IO.puts("\nEnvío notificaciones SECUENCIAL:")
    envio1 = enviar_notificacion_secuencial(notificaciones)
    Enum.each(notificaciones, fn notificacion ->
      IO.puts("Enviada a #{notificacion.usuario} (canal #{notificacion.canal})")
    end)
    IO.puts("\n")

    IO.puts("\nEnvío notificaciones CONCURRENTE:")
    envio2 = enviar_notificacion_concurrente(notificaciones)
    Enum.each(notificaciones, fn notificacion ->
      IO.puts("Enviada a #{notificacion.usuario} (canal #{notificacion.canal})")
    end)


    speed_up = run_benchmark(notificaciones)
    IO.puts("\nSpeedup concurrente vs secuencial: #{speed_up}\n")

    IO.puts("\nSimulación terminada.\n")
  end
end
EnviarNotificacion.iniciar()
