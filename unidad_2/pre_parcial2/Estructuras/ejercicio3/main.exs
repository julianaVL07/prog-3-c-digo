defmodule Main do

  def main do
    dispositivo1 = Dispositivo.crear("001", "Celular", "Xiaomi", "nuevo")
    |> IO.inspect()

    apto= Dispositivo.es_apto_para_prestamo(dispositivo1)
    IO.puts("Es apto para prestamo: #{apto}")

    Dispositivo.actualizar_estado(dispositivo1, "dañado")
    |> IO.inspect()
  end
end

Main.main()
