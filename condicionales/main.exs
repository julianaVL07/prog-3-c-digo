defmodule Main do
    def main do
        #Util.input("ingrese su edad: ", :integer)
        #|>condicion_if()

        #Util.input("Ingrese la contraseña: ", :string)
        #|>condicion_unless()

        #Util.input("Ingrese un número:", :integer)
        #|>condicion2_if()

        #Util.input("Ingrese un número:", :integer)
        #|>condicion2_unless()

        Util.input("Ingrese una nota (0 a 5):", :float)
        |>condicion_cond()

        #Util.input("Ingrese una letra :", :string)
        #|>condicion_case()

    end

    #Un prog que reciba la edad de una persona y muestre si es mayor de edad (18 años o más) o no. (if)

    def condicion_if(edad) do
        if edad > 17 do
            Util.show_message("La persona es mayor de edad.")
        else
            Util.show_message("La persona No es mayor de edad.")
        end
    end

    #Un programa que reciba un número e indique si es positivo. (if)

    def condicion2_if(numero) do
        if numero > 0 do
            Util.show_message("El número es positivo ")
        else
            if numero < 0 do
             Util.show_message("El número es negativo")
            else
             Util.show_message("El número es cero")
            end
        end
    end

    #Un prog que reciba una contraseña y muestre un mensaje de error a menos que la contraseña sea "1234". (unless)

    def condicion_unless(pass) do
        unless pass==="1234" do
            Util.show_message("ERROR")
        else
            Util.show_message("correcto")

        end
    end

    #Un programa que reciba un número y muestre "El número no es cero" a menos que sea exactamente 0. (unless)

    def condicion2_unless(numero) do
        unless numero===0 do #unless= a menos que , salvo que
            Util.show_message("El número no es cero")
        else
            Util.show_message("El número es cero")
        end
    end

   #Un programa que reciba una nota (0 a 5) y muestre: (cond)
   #"Excelente" si es mayor o igual a 4.5.
   #"Aprobado" si está entre 3.0 y 4.4.
   #"Reprobado" si es menor a 3.0.

    def condicion_cond(nota) do
        cond do
            nota >= 4.5 ->
                Util.show_message("Excelente")
                Util.show_message("La mejor nota")
            nota >= 3.0 -> Util.show_message("Aprobado")
            nota < 3.0 -> Util.show_message("Reprobado")
            true -> Util.show_message("Nota inválida")
        end
    end

    #Un programa que lea un carácter y muestre si es una vocal ("a", "e", "i", "o", "u") o una consonante. (case)

    def condicion_case(char) do
        case char do
            "a" -> Util.show_message("Vocal")
            "e" -> Util.show_message("Vocal")
            "i" -> Util.show_message("Vocal")
            "o" -> Util.show_message("Vocal")
            "u" -> Util.show_message("Vocal")
            _ -> Util.show_message("Consonante") #si no son los anteriores es este
        end
    end

    #ejemplo de un ejercicio de la práctica
    # def div_segura(entrada) do
        #case entrada do
       # {_, 0} -> ERROR
       # {dividendo,divisor} ->
        #_
       # end
   # end
end


Main.main()
