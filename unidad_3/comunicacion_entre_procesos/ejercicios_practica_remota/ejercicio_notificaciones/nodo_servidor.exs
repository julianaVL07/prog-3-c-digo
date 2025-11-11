defmodule NodoServidor do
  @nodo_servidor :"servidor@10.180.197.174"
  @nombre_proceso :notificacion

  def main do
    IO.puts("INICIANDO SERVIDOR")
    iniciar_nodo(@nodo_servidor)
    registrar_servicio(@nombre_proceso)
    procesar_mensajes()
  end

  defp iniciar_nodo(nombre) do
    Node.start(nombre)
    Node.set_cookie(:my_cookie)
  end

  defp registrar_servicio(nombre),
    do: Process.register(self(), nombre)

  defp procesar_mensajes do
    receive do
      {cliente, :enviar} ->
        resultado = EnviarNotificacion.iniciar()
        send(cliente, resultado)
        procesar_mensajes()

      {cliente, :fin} ->
        send(cliente, :fin)

      _ ->
        procesar_mensajes()
    end
  end
end

Code.require_file("enviar_notificacion.exs", __DIR__)
NodoServidor.main()
