# Inicia el flujo en Elixir
IO.puts(">>> Elixir: iniciando ejecución de Generar.java")

# Ejecutar la clase Java "Generar" y capturar:
# - salida: lo que Java imprime en consola (stdout)
# - codigo: el código de salida del proceso (0 = éxito, distinto de 0 = error)
{salida, codigo} = System.cmd("java", ["InvestigacionJavaElixir.Generar"], cd: "..")

# Verifica si Generar.java terminó correctamente
if codigo == 0 do
  # Limpia espacios y saltos de línea de la salida capturada
  nombre = String.trim(salida)

  # Muestra en consola de Elixir el dato recibido desde Java
  IO.puts(">>> Elixir: dato recibido desde Generar: #{nombre}")

  IO.puts(">>> Elixir: enviando dato a Mostrar.java")

  # Ejecutar la clase Java "Mostrar" pasando como argumento el dato capturado
  {_, cod_mostrar} = System.cmd("java", ["InvestigacionJavaElixir.Mostrar", nombre], cd: "..")

  # Verificar si Mostrar.java terminó correctamente
  if cod_mostrar == 0 do
    IO.puts(">>> Elixir: Mostrar.java finalizó correctamente")
  else
    IO.puts(">>> Elixir: error al ejecutar Mostrar.java")
  end
else
  # Si Generar.java falló, notificar en consola
  IO.puts(">>> Elixir: error al ejecutar Generar.java")
end

# Mensaje final del flujo completo
IO.puts(">>> Elixir: flujo completo finalizado")
