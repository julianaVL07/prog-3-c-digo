defmodule Main do

  def main do
    docente1 = Docente.crear("Daniel")
    docente2 = Docente.crear("Yuliana")
    curso1 = Curso.crear("001", "Calculo Diferencial" ,4 ,docente1 )
    IO.inspect(curso1)

    estado= Curso.curso_de_alta_carga(curso1)
    IO.puts("El curso es de alta carga: #{estado}")

    Curso.asignar_nuevo_docente(curso1, docente2)
    |> IO.inspect()

  end
end

Main.main()
