defmodule Main do
  def main do

    estudiante1 = Estudiante.crear("1234", "Julia", "Julia@uq.edu.co", 6)
    IO.inspect(estudiante1)

    Estudiante.promover_semestre(estudiante1)
    |>IO.inspect()

    validar= Estudiante.validar_correo(estudiante1)
    IO.puts("El correo es válido : #{validar}")
  end
end

Main.main()
