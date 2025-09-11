# Crear listas
lista = [1, 2, 3, 4]
mixta = [1, "hola", :atom, 3.14]

# Concatenar
[1, 2, 3] ++ [4, 5]   # => [1, 2, 3, 4, 5]

# Quitar elementos
[1, 2, 3, 4] -- [2, 4]  # => [1, 3]

# Acceso
hd([10, 20, 30])  # => 10 (cabeza)
tl([10, 20, 30])  # => [20, 30] (cola)

# Recorrer lista
Enum.map([1, 2, 3], fn x -> x * 2 end) # => [2, 4, 6] #recorre cada elemento de la lista y lo multiplica por 2
Enum.filter([1, 2, 3, 4], fn x -> rem(x, 2) == 0 end) # => [2, 4] #recorre cada elemento de la lista y filtra los números pares

# map → transforma cada elemento.
# filter → selecciona solo algunos elementos según condición.
