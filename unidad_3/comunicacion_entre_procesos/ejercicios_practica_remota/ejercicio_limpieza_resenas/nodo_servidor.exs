defmodule NodoServidor do
  @nodo_servidor :"servidor@10.180.197.174"
  @nombre_proceso :resenas

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

  defp registrar_servicio(nombre_servicio_local),
    do: Process.register(self(), nombre_servicio_local)

  defp procesar_mensajes do
    receive do
      {cliente, :limpiar_resenas} ->
        IO.puts("Procesando limpieza de reseñas...")
        resultado = LimpiarResenas.iniciar()
        send(cliente, "\nLimpieza y benchmark completados:\n#{resultado}")
        procesar_mensajes()

      {cliente, :fin} ->
        send(cliente, :fin)
        IO.puts("Servidor finalizado.")

      _ ->
        procesar_mensajes()
    end
  end
end

# Cargar el módulo de reseñas
Code.require_file("limpiar_resenas.exs", __DIR__)
NodoServidor.main()
