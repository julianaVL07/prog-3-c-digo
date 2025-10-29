defmodule Main do
  def main do
    # Crear docentes de prueba
    docentes = [
      Docente.crear("1", "Ana", "Titular"),
      Docente.crear("2", "Luis", "Asistente"),
      Docente.crear("3", "Marta", "Titular"),
      Docente.crear("4", "Juan", "Asociado"),
      Docente.crear("5", "Sofia", "Titular")
    ]

    # Escribir todos los docentes en docentes.csv
    Docente.escribir_csv(docentes, "docentes.csv")

    # Leer docentes desde el archivo
    docentes_leidos = Docente.leer_csv("docentes.csv")
    IO.inspect(docentes_leidos, label: "Docentes leídos")

    # Filtrar solo los titulares
    titulares = Enum.filter(docentes_leidos, fn d -> d.categoria == "Titular" end)

    # Escribir titulares en docentes_titulares.csv
    Docente.escribir_csv(titulares, "docentes_titulares.csv")
  end
end

Main.main()
