tupla = {:ok, "Mensaje", 200} #no podemos agregar elementos a una tupla. No es enumerable.

elem(tupla, 2) #acceder a un elemento por su índice

tupla= put_elem(tupla, 0, :error) #modificar un elemento de la tupla, devuelve una nueva tupla

{type, message, code} = tupla #asignación directa de los elementos de la tupla a variables
