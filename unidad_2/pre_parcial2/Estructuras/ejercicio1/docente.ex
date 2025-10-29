defmodule Docente do

  defstruct nombre: ""

  def crear(nombre) do
    %Docente{nombre: nombre}
  end
  
end
