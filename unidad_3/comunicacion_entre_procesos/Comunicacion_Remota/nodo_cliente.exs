defmodule NodoCliente do
  @ip_cliente "10.180.197.189"   # <- cambia aquí por la IP del cliente
  @ip_servidor "10.180.197.174"  # <- cambia aquí por la IP del servidor

  @nombre_servicio_local :servicio_respuesta
  @servicio_local {@nombre_servicio_local, String.to_atom("nodocliente@" <> @ip_cliente)}
  @nodo_remoto String.to_atom("nodoservidor@" <> @ip_servidor)
  @servicio_remoto {:servicio_cadenas, @nodo_remoto}

  @mensajes [
    {:mayusculas, "Hola"},
    {:mayusculas, "Sara"},
    {:minusculas, "Sofia"},
    {&String.reverse/1, "Bolaños"},
    "Uniquindio",
    :fin
  ] 

  def main() do
    IO.puts("PROCESO PRINCIPAL (Cliente iniciado en #{@ip_cliente})")
    registrar_servicio(@nombre_servicio_local)

    case establecer_conexion(@nodo_remoto) do
      true -> iniciar_produccion()
      false -> IO.puts("No se pudo conectar con el nodo servidor remoto")
    end
  end

  defp registrar_servicio(nombre_servicio_local),
    do: Process.register(self(), nombre_servicio_local)

  defp establecer_conexion(nodo_remoto) do
    case Node.connect(nodo_remoto) do
      true ->
        IO.puts("Conectado al nodo remoto #{inspect nodo_remoto}")
        true

      false ->
        IO.puts("No se logró la conexión con #{inspect nodo_remoto}")
        false
    end
  end

  defp iniciar_produccion() do
    enviar_mensajes()
    recibir_respuestas()
  end

  defp enviar_mensajes() do
    Enum.each(@mensajes, &enviar_mensaje/1)
  end

  defp enviar_mensaje(mensaje) do
    send(@servicio_remoto, {@servicio_local, mensaje})
  end

  defp recibir_respuestas() do
    receive do
      :fin ->
        IO.puts("Fin de la comunicación.")
        :ok

      respuesta ->
        IO.puts("\t -> \"#{respuesta}\"")
        recibir_respuestas()
    end
  end
end

NodoCliente.main()
