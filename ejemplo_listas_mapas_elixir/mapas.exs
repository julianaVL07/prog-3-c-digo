# Crear un mapa
mapa = %{:nombre => "Ana", :edad => 25}
mapa2 = %{nombre: "Ana", edad: 25}  # sintaxis abreviada para átomos

# Acceso
mapa[:nombre]    # => "Ana"
mapa2.edad       # => 25

# Agregar o actualizar
mapa3 = Map.put(mapa2, :ciudad, "Bogotá")
# => %{nombre: "Ana", edad: 25, ciudad: "Bogotá"}

mapa4 = %{mapa2 | edad: 30}  # actualizar (solo si la clave ya existe)
# => %{nombre: "Ana", edad: 30}

# Eliminar clave
Map.delete(mapa3, :ciudad)  # => %{nombre: "Ana", edad: 25}

# Recorrer mapa
Enum.each(mapa2, fn {k, v} -> IO.puts("#{k}: #{v}") end)
# nombre: Ana
# edad: 25
