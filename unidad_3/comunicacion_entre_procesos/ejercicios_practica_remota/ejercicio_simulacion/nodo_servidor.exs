defmodule NodoServidor do
  @nodo_servidor :"servidor@10.180.197.174"
  @nombre_proceso :servicio_cadenas

  def main() do
    IO.puts("SE INICIA EL SERVIDOR")
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

  defp procesar_mensajes() do
    receive do
      {productor, :fin} ->
        send(productor, :fin)

      {productor, :carrera} ->
        resultado = Carrera.iniciar()
        send(productor, resultado)
        procesar_mensajes()

      _ ->
        procesar_mensajes()
    end
  end
end

Code.require_file("carrera.exs", _DIR_)
NodoServidor.main()
