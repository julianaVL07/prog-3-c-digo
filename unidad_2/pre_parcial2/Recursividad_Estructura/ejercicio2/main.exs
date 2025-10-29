defmodule Main do

  def main do
    # Crear algunos usuarios de prueba
    u1 = Usuario.crear("1", "ana@uq.edu.co")
    u2 = Usuario.crear("2", "juan@gmail.com")
    u3 = Usuario.crear("3", "luis@uq.edu.co")
    u4 = Usuario.crear("4", "maria@hotmail.com")

    # Lista de usuarios
    usuarios = [u1, u2, u3, u4]

    # Filtrar usuarios cuyo correo termina en @uq.edu.co
    usuarios_filtrados = Usuario.filtrar_usuarios(usuarios)

    IO.inspect(usuarios_filtrados)
  end
end
Main.main()
