defmodule NodoServidor do
  @nodo_servidor :"servidor@10.180.197.174"
  @nombre_proceso :servicio_validar

  def main() do
    IO.puts("SE INICIA EL SERVIDOR")
    iniciar_nodo(@nodo_servidor)
    registrar_servicio(@nombre_proceso)
    procesar_mensajes()
  end

  defp iniciar_nodo(nombre) do
    Node.start(nombre)
    Node.set_cookie(:my_cookie)
  end

  defp registrar_servicio(nombre_servicio_local) do
    Process.register(self(), nombre_servicio_local)
  end

  defp procesar_mensajes() do
    receive do
      {cliente, :fin} ->
        send(cliente, :fin)

      {cliente, :validar} ->
        IO.puts("\n Solicitud recibida del cliente, iniciando validación...\n")
        resultado = Validar.iniciar()
        send(cliente, resultado)
        IO.puts(" Resultados enviados al cliente.\n")
        procesar_mensajes()

      _ ->
        procesar_mensajes()
    end
  end
end

Code.require_file("validar.exs", _DIR_)

NodoServidor.main()
