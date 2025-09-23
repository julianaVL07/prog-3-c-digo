#Recorrer (each)
#Transformar (map)
#Filtrar (filter)
#Buscar (find)
#Reducir (reduce)

list= [1,2,3]
Enum.each(list, fn x -> IO.puts x end) #recorrer una lista
Enum.map(list, fn x -> x+2 end) #transformar una lista
