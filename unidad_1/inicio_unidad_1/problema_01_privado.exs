defmodule ProblemaPrivado do
  defp mostrar_mensaje_privado(mensaje) do
    mensaje
    |>IO.puts()
  end

  def invocacion_privado() do
    "Bienvenidos a la empresa Once Ltda"
    |>mostrar_mensaje_privado()
  end
end

ProblemaPrivado.invocacion_privado()
