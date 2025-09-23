defmodule Main do
  def main do
    #Util.input("Ingrese el monto de su retiro: ", :float)
    #|> condicion3_if()

    #Util.input("Ingrese el estado de su entrega (activo/inactivo):", :string)
    #|> condicion3_unless()

    #Util.input("Ingrese la temperatura en grados Celsius:", :float)
    #|> condicion2_cond()

    #Util.input("Ingrese el nivel del enemigo derrotado: ", :integer)
    #|> condicion3_cond()

    #Util.input("Ingrese para la división un número 1 y un número 2 separados por coma (ej: 10,2):", {:tuple, :integer})
    #|> condicion2_case()

    #Util.input("Ingrese un código de triage (:rojo, :amarillo, :verde):", :string)
    #|> condicion3_case()

    Util.input("Ingrese las coordenadas de un punto en el plano (x,y) (ej: 10,2): ", {:tuple, :integer})
    |> condicion4_case()

  end

  #En un sistema bancario, cuando un cliente realiza un retiro, el programa debe verificar si el saldo en su cuenta es suficiente:
  #Si el saldo es mayor o igual al monto solicitado, el retiro se aprueba y se muestra el nuevo saldo.
  #Si no, debe mostrarse “Fondos insuficientes”. (if)

  def condicion3_if(retiro) do
    saldo=100000
    if saldo >= retiro do
       saldo_nuevo= saldo - retiro
       Util.show_message ("Retiro aprobado, su nuevo saldo es: #{round(saldo_nuevo)}")
    else
        Util.show_message("Fondos insuficientes")
    end
  end

  #En una aplicación de pedidos a domicilio, un repartidor solo puede iniciar una nueva entrega a menos que ya tenga una en curso:
  #Si no tiene pedidos activos, el sistema le asigna el nuevo pedido.
  #Si ya tiene uno, debe mostrar “No puede tomar un nuevo pedido hasta entregar el actual”. (unless)

  def condicion3_unless(estado_pedido) do
    unless estado_pedido==="activo" do
      Util.show_message("Nuevo pedido asignado")
    else
      Util.show_message("No puede tomar un nuevo pedido hasta entregar el actual")
    end

  end

  #Un programa que reciba la temperatura en grados Celsius y diga:  (cond)
  # "Frío" si es menor a 15.
  # "Templado" si está entre 15 y 25.
  # "Caluroso" si es mayor a 25.

  def condicion2_cond(temperatura) do
    cond do
      temperatura < 15 -> Util.show_message("Frío")
      temperatura >=15 && temperatura <=25 -> Util.show_message("Templado")
      temperatura >25 -> Util.show_message("Caluroso")
      true -> Util.show_message("Temperatura inválida")
    end
  end

  #En un videojuego, un jugador gana puntos dependiendo de la dificultad del enemigo derrotado:
  #Nivel menor a 3 → +10 puntos.
  #Nivel entre 3 y 6 → +20 puntos.
  #Nivel mayor a 6 → +50 puntos.

  def condicion3_cond(nivel) do
    cond do
      nivel > 0 && nivel < 3 -> Util.show_message("Has ganado 10 puntos")
      nivel >=3 && nivel <=6 -> Util.show_message("Has ganado 20 puntos")
      nivel > 6 -> Util.show_message("Has ganado 50 puntos")
      true -> Util.show_message ("Nivel inválido")
    end
  end

  #Escribe un programa que realice una división segura entre dos números. (case)
  #Si el divisor es 0, debe devolver un error.
  #Si la división es exacta (sin residuo), mostrar el cociente.
  #Si no es exacta, mostrar cociente y residuo.

  def condicion2_case({numero1,numero2}) do
    case {numero1,numero2} do
        {_, 0} -> Util.show_message("ERROR")
        {numero1,numero2} when rem(numero1,numero2) == 0 ->
          cociente = div(numero1,numero2)
          Util.show_message("Cociente: #{cociente}")
        {numero1,numero2} when rem(numero1,numero2) != 0 ->
          cociente= div(numero1,numero2)
          residuo= rem(numero1,numero2)
          Util.show_message("Cociente: #{cociente}, Residuo: #{residuo}")
        _ -> Util.show_message("Entrada inválida")
    end
  end

  #En un sistema de atención médica, se recibe un código de triage que clasifica a los pacientes:
  # :rojo → Atención inmediata.
  # :amarillo → Atención en menos de 30 minutos.
  # :verde → Atención en sala general.
  # Cualquier otro valor → “Código no válido”.

def condicion3_case(codigo) do
  case codigo do
    ":rojo" -> Util.show_message("Atención inmediata")
    ":amarillo" -> Util.show_message("Atención en menos de 30 minutos")
    ":verde" -> Util.show_message("Atención en sala general")
    _ -> Util.show_message("Código no válido")
  end
end

  # Un punto en un plano cartesiano se representa como una tupla {x, y}.
  # Si el punto está en el origen (0, 0) mostrar “Está en el origen”.
  # Si está sobre los ejes X o Y, indicar en cuál eje.
  # En cualquier otro caso, mostrar “Está en el plano”.

def condicion4_case({x,y}) do
    case {x,y} do
      {0,0} -> Util.show_message("Está en el origen")
      {_,0} -> Util.show_message("Está sobre el eje x")
      {0,_} ->Util.show_message("Está sobre el eje y")
      _ -> Util.show_message("Está en el plano")
    end
  end
end

Main.main()
