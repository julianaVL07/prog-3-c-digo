defmodule Main do
  @moduledoc """
    Cálculo del Salario de un Empleado.

  """

   @doc """
   Solicita el nombre del empleado, su salario base y las horas extras trabajadas, luego calcula y muestra el salario total.

  """

  def ejercicio4() do
    nombre_empleado= Util.input("Ingrese el nombre del empleado: ", :string)
    salario_base= Util.input("Ingrese el salario base: ", :float)
    horas_extras_trabajadas= Util.input("Ingrese la cantidad de horas extras trabajadas: ", :integer)
    valor_hora_extra=calcular_valor_hora_extra(salario_base, horas_extras_trabajadas)
    salario_total=calcular_salario_total(salario_base, valor_hora_extra)
    "El salario total de #{nombre_empleado} es de $#{Float.round(salario_total, 2)}" #redondeo para la salida.
    |>Util.show_message()
  end

  @doc """
    Calcula el valor total de las horas extras trabajadas.

  """
  def calcular_valor_hora_extra(salario_base, horas_extras_trabajadas)do
    salario_base/173*1.5*horas_extras_trabajadas # 173 son las horas normales laborales en colombia.

  end

  @doc """
    Calcula el salario total de un empleado dado su salario base y el valor total de las horas extras trabajadas.

  """

  def calcular_salario_total(salario_base, valor_hora_extra)do
    salario_base+valor_hora_extra
  end

end

Main.ejercicio4()
