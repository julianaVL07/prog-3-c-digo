defmodule Main do
  def main do
      keyword_list_config= keyword_list_config()
      IO.inspect(keyword_list_config, label: "Configuraciones: ")
      nueva_keyword_list_config= agregar_clave(keyword_list_config)
      IO.puts("\nkeyword_list con nueva clave: ")
      IO.inspect(nueva_keyword_list_config)
      map_config=convertir_a_mapa(nueva_keyword_list_config)
      IO.puts("\nConversión a mapa: ")
      IO.inspect(map_config)
      verificacion_clave=verificar_clave(map_config)
      IO.puts("\nverificación existencia de clave usuario: #{verificacion_clave}")
      IO.puts("\nclaves y valores del mapa final")
      imprimir_mapa(map_config)

  end

  #Un programa recibe configuraciones como una keyword list [modo: :rapido, intentos:
  #3, usuario: "admin"].

  def keyword_list_config() do
    [modo: :rapido, intentos: 3, usuario: "Admin"]
  end

  #Agregar una clave :activo con valor true.

  def agregar_clave(keyword_list_config) do
    Keyword.put(keyword_list_config, :activo, true)
  end

  # Convertir la keyword list en un mapa.

  def convertir_a_mapa(keyword_list_config) do
    #Map.new(keyword_list_config)
    #Enum.map(keyword_list_config, fn {clave, valor} -> %{clave => valor} end) devolveria 3 mapas cada uno por cada pareja
    Enum.into(keyword_list_config, %{})
  end

  #Verificar con Map.has_key?/2 si existe la clave :usuario.

  def verificar_clave(map_config) do
    Map.has_key?(map_config, :usuario) #tambien se puede asi "usuario"
  end

  #Usar Enum.each/2 para imprimir las claves y valores del mapa final.

  def imprimir_mapa(map_config) do
    Enum.each(map_config, fn {clave,valor} -> IO.inspect({clave,valor}) end)
    Enum.each(map_config, fn {clave,valor} -> IO.puts("#{clave} : #{valor}")end) #o así
  end

end

Main.main()

#Tuplas de 2 elementos → Map.new/1 es lo más directo.

#Tuplas de más de 2 elementos → necesitas Enum.map/2 y construir el mapa manualmente para cada elemento.
