defmodule NodoServidor do
  @nodo_servidor :"servidor@10.180.197.174"
  @nombre_proceso :descuentos

  def main do
    IO.puts("INICIANDO SERVIDOR")
    iniciar_nodo(@nodo_servidor)
    registrar_servicio(@nombre_proceso)
    procesar_mensajes()
  end

  def iniciar_nodo(nombre) do
    Node.start(nombre)
    Node.set_cookie(:my_cookie)
  end

  defp registrar_servicio(nombre_servicio_local),
    do: Process.register(self(), nombre_servicio_local)

  defp procesar_mensajes do
    receive do
      {cliente, :calcular_descuentos} ->
        resultado = Descuento.iniciar()
        send(cliente, resultado)
        procesar_mensajes()

      {cliente, :fin} ->
        send(cliente, :fin)

      _ ->
        procesar_mensajes()
    end
  end
end

Code.require_file("descuento.exs", __DIR__)
NodoServidor.main()
