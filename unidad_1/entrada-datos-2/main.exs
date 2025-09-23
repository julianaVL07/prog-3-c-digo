defmodule Main do
  def main do
    pedir_texto()
    pedir_numero()
    pedir_decimal()
  end

  def pedir_texto() do
  "Ingrese su nombre: "
  |>Util.input(:string) # Aridad dos porque recibe (message, tipo)
  |>Util.show_message()
  end

  def pedir_numero() do
  x = Util.input( "Ingrese un número: ", :integer) #relacionar lo de izq y lo de derecha

    "El numero ingresado es entero: #{is_integer(x)}" #interpolación
    |>Util.show_message()
  end

  def pedir_decimal() do
     x = Util.input( "Ingrese un número: ", :float) #relacionar lo de izq y lo de derecha

    "El numero ingresado es decimal: #{is_float(x)}" #interpolación
    |>Util.show_message()
  end

end


Main.main()
