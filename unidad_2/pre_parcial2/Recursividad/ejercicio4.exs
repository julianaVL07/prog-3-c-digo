defmodule SubconjuntoConSumaObjetivo do

  @moduledoc"""
    Se necesita una función recursiva (incluir/excluir) que, dada una lista de enteros positivos
    y un objetivo, retorne alguna combinación que sume exactamente el objetivo, o {:error, :sin_solucion}.
  """
  def main do
    lista = [1,2,3,4]
    objetivo = 6
    IO.inspect(suma_con_objetivo(lista, objetivo))
  end

  def suma_con_objetivo(_,0) do
    []
  end

  def suma_con_objetivo([], _objetivo) do
    {:error, :sin_solucion}
  end

  def suma_con_objetivo([head | tail], objetivo) do
  # Intentar incluir el head
  caso_con_head = suma_con_objetivo(tail, objetivo - head)
  if caso_con_head != {:error, :sin_solucion} do
    [head | caso_con_head]
  else
    # Intentar sin incluir el head
    suma_con_objetivo(tail, objetivo)
  end
  end
end

SubconjuntoConSumaObjetivo.main()
