defmodule NodoCliente do
  @nodo_cliente :"cliente@10.180.197.189"
  @nodo_servidor :"servidor@10.180.197.174"
  @nombre_proceso :servicio_validar

  @mensajes [
    :validar,
    :fin
  ]

  def main() do
    IO.puts("SE INICIA EL CLIENTE")
    iniciar_nodo(@nodo_cliente)
    establecer_conexion(@nodo_servidor)
    |> iniciar_validacion()
  end

  defp iniciar_nodo(nombre) do
    Node.start(nombre)
    Node.set_cookie(:my_cookie)
  end

  defp establecer_conexion(nodo_remoto) do
    Node.connect(nodo_remoto)
  end

  defp iniciar_validacion(false), do: IO.puts("No se pudo conectar con el nodo servidor remoto")

  defp iniciar_validacion(true) do
    enviar_mensajes()
    recibir_respuestas()
  end

  defp enviar_mensajes() do
    Enum.each(@mensajes, &enviar_mensaje/1)
  end

  defp enviar_mensaje(mensaje) do
    send({@nombre_proceso, @nodo_servidor}, {self(), mensaje})
  end

  defp recibir_respuestas() do
    receive do
      :fin ->
        IO.puts("→ Comunicación finalizada.")

      respuesta ->
        IO.puts(respuesta)
        recibir_respuestas()
    end
  end
end

NodoCliente.main()
