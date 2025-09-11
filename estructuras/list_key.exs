list_kW = [name: "Jhan", edad: 24] #lista(keyword list)
keyword.get(list_kW, :name) #acceder a un elemento por su clave

keyword.put(list_kW, :name, "Carlos") #modificar un elemento de la lista, devuelve una nueva lista y agregar un elemento a la lista
keyword.delete(list_kW, :name) #eliminar un elemento de la lista por su clave, devuelve una nueva lista
keyword.get_values(list_kW) #obtener valores de una clave específica

#Keyword.get_values(list, :clave) → valores de una clave específica.

#Enum.map(list, fn {_k, v} -> v end) → todos los valores.

#Si solo te interesa un valor → get.

#Si quieres todos los valores (cuando una clave puede repetirse) → get_values.


