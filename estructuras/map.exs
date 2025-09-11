map1= %{"nombre" => "Jhan"} #no repetidos. Funciones propias.
map2= %{nombre: "Jhan"} #Atomos como claves.

map2= Map.put(map2, :nombre, "Carlos") #agregar o modificar un elemento al mapa, devuelve un nuevo mapa
map3= %{:nombre => "Carlos", "nombre" => "Carlos"}
Map.get(map3, "nombre") #acceder a un elemento por su clave
Map.get(map3, :nombre) #acceder a un elemento por su clave

Map.delete(map3, :nombre) #eliminar un elemento del mapa por su clave, devuelve un nuevo mapa
