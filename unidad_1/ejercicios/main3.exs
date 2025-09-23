defmodule Main do
  @moduledoc"""
  Modulo que calcula el salario neto de un empleado
  """

   @doc"""
    Solicita los datos del empleado, calcula el salario neto y lo muestra.
  """
  def main() do
    nombre= Util.input_data("Ingresa el nombre: ")
    horas_string= Util.input_data("Ingresa horas trabajadas: ")
    valor_string= Util.input_data("Ingresa valor por hora: ")


    horas= String.to_integer(horas_string)
    valor= String.to_integer(valor_string)

    salario_neto=calcular_salario_neto(horas,valor)
    salario_neto_string= Integer.to_string(salario_neto)

    mensaje= "El salario de #{nombre} es: $ #{salario_neto_string}"

    Util.show_message(mensaje)

end


@doc"""
  calcular horas extras dependiendo de las horas trabajadas
  """

    def calcular_horas_extra(horas,valor) do
      if horas > 160 do
        horas_extras=horas-160
        round(horas_extras* valor * 1.25)
      else
        0
      end
    end

@doc"""
  calcular horas base dependiendo de las horas trabajadas
  """
    def calcular_horas_base(horas) do
      if horas >160 do
        160
      else
        horas
      end
    end

 @doc"""
  calcular salario neto dependiendo de las horas trabajadas y el valor por hora
  """
    def calcular_salario_neto(horas, valor) do
      salario_base= calcular_horas_base(horas) * valor
      horas_extra= calcular_horas_extra(horas,valor)
      salario_base + horas_extra
    end
end


Main.main()
