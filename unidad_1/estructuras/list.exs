list = ["Jhan", 24, :ok] #se pueden agregar elementos a la lista. Es enumerable.

[:ingeniero | list] #juntar el atomo a la lista que está

list2 = [:ingeniero | list] #le vamos a agregar elemento al inicio (devuelve una nueva lista)
list2= list2 ++ [2024] #le vamos a agregar el elemento nuevo al final

[head | tail] = list2 #head (cabeza) es el primer elemento y tail (cola) es el resto de los elementos de la lista
[head |[head2 | tail]] = list2
[a, b, c] = list2 #asignación directa de los elementos de la lista a variables

list2 -- list #eliminar los elementos de list de list2

Enum.at(list2, 3) #acceder a un elemento por su índice

Enum.at(list2, 5, nil) #acceder a un elemento por su índice

map 
filter
