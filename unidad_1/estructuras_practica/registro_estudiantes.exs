defmodule Main do
  def main do
      list_estudiantes= estudiantes_curso()
      IO.inspect(list_estudiantes)
      list_estudiantes_nota=condicion_nota(list_estudiantes)
      IO.puts("\nestudiantes con nota mayor a 3.0:")            # imprime un salto de línea
      IO.inspect(list_estudiantes_nota)
      list_mapas_estudiantes= convertir_lista(list_estudiantes)
      IO.puts("\nconversion a mapas")            # imprime un salto de línea
      IO.inspect(list_mapas_estudiantes)
      list_rango_edad = rango_edad(list_mapas_estudiantes)
      IO.puts("\nestudiantes agrupados por edad:")            # imprime un salto de línea
      IO.inspect(list_rango_edad)
  end

  #Representar a los estudiantes de un curso en una lista de tuplas de la forma
  #{"Nombre", edad, nota}.

  def estudiantes_curso()do
    [{"Sofia", 20, 4.5},
    {"Sara", 19, 3.0},
    {"Cesar", 26, 2.5}
  ]
  end

  #Usar Enum.filter/2 para obtener los estudiantes con nota mayor o igual a 3.0.

  def condicion_nota(list_estudiantes) do
    Enum.filter(list_estudiantes, fn estudiante -> elem(estudiante, 2) >=3.0 end)
  end

  #Convertir la lista de tuplas en una lista de mapas con claves :nombre, :edad, :nota.

  def convertir_lista(list_estudiantes) do
    Enum.map(list_estudiantes, fn {nombre, edad, nota} -> %{nombre: nombre, edad: edad, nota: nota} end)
    #Enum.into(list_estudiantes, []) #en el parcial se puede así
    #|> IO.inspect()
  end

  #Agrupar a los estudiantes por rango de edad usando Enum.group_by/2 (menores de
  #20, entre 20 y 25, mayores de 25).

  def rango_edad(list_mapas_estudiantes) do
    Enum.group_by(list_mapas_estudiantes, fn estudiante ->
      edad= estudiante.edad

      cond do
        edad < 20 -> :Menores_20
        edad >=20 && edad <=25 -> :Entre_20_25
        edad>25 -> :Mayores_25
        true -> :Inválido
      end
    end )

  end



end

Main.main()

#Tupla	elem(tupla, índice)
#Mapa	mapa.clave o Map.get(mapa, :clave)
#Lista	lista[indice] (menos común, porque Enum es más seguro)
