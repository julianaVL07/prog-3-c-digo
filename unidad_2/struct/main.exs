defmodule Main do
  def main do
    #creacion de un struct
    u1= %User{name: "Jhan", pass: "123"}
    IO.inspect(u1)

    #acceso a la informacion del struct
    IO.puts(u1.name)

    #modificacion de un struct
    u2=%User{u1 | pass: "456"}
    IO.inspect(u2)
  end
end

Main.main
