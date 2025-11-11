defmodule NodoCliente do
  @nodo_cliente :"cliente@10.180.197.189"
  @nodo_servidor :"servidor@10.180.197.174"
  @nombre_proceso :resenas

  @mensajes [
    :limpiar_resenas,
    :fin
  ]

  def main do
    IO.puts("INICIANDO CLIENTE")
    iniciar_nodo(@nodo_cliente)
    establecer_conexion(@nodo_servidor)
    |> iniciar_comunicacion()
  end

  defp iniciar_nodo(nombre) do
    Node.start(nombre)
    Node.set_cookie(:my_cookie)
  end

  defp establecer_conexion(nodo_remoto) do
    Node.connect(nodo_remoto)
  end

  defp iniciar_comunicacion(false), do: IO.puts("No se pudo conectar con el nodo servidor.")

  defp iniciar_comunicacion(true) do
    IO.puts("Conexión establecida con el servidor.")
    Enum.each(@mensajes, &enviar_mensaje/1)
    recibir_respuestas()
  end

  defp enviar_mensaje(mensaje) do
    send({@nombre_proceso, @nodo_servidor}, {self(), mensaje})
  end

  defp recibir_respuestas do
    receive do
      :fin ->
        IO.puts("\n Comunicación finalizada.")

      respuesta ->
        IO.puts("\n--- RESPUESTA DEL SERVIDOR ---\n#{respuesta}")
        recibir_respuestas()
    end
  end
end

NodoCliente.main()
