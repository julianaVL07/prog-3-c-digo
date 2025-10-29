defmodule Main do

  def main do
    est1 = Estudiante.crear("1", "Julia", [5, 4, 3])
    est2 = Estudiante.crear("2", "Sara", [4, 4, 4])
    est3 = Estudiante.crear("3", "Lau", [3, 2, 5])

    lista = [est1, est2, est3]
    IO.inspect(Estudiante.calcular_promedios(lista))
    end
end

Main.main()
