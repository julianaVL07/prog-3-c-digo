defmodule Validar do

    @moduledoc"""
    Contexto: validar lotes de usuarios importados.
    Datos: %User{email, edad, nombre}.
    Trabajo: validar/1 (correo con @, edad >= 0, nombre no vacío) + :timer.sleep(3..10).
    Secuencial vs Concurrente: sobre miles de usuarios.
    Salida: {email, :ok | {:error, lista_de_errores}}; speedup.
    """

    def validar_datos(usuario) do
    errores = []

    errores =
      if String.contains?(usuario.email, "@") do
        errores
        else
        ["Email inválido" | errores]
      end

    errores =
      if usuario.edad >= 0 do
        errores
       else
        ["Edad inválida" | errores]
      end

    errores =
      if String.trim(usuario.nombre) != "" do
        errores
      else
        ["Nombre vacío" | errores]
      end

    # Simula el tiempo de validación
    :timer.sleep(Enum.random(3..10))

    # Devuelve el resultado
    if errores == [] do
      {usuario.email, :ok}
    else
      {usuario.email, {:error, Enum.reverse(errores)}}
    end
  end

    def validar_datos_secuencial(usuarios)do
      Enum.map(usuarios, fn usuario -> validar_datos(usuario) end)
    end

    def validar_datos_concurrente(usuarios) do
    Enum.map(usuarios, fn usuario ->
      Task.async(fn -> validar_datos(usuario) end)
    end)
    |> Task.await_many()
    end

    def lista_usuarios() do
  [
    %Usuario{email: "ana@example.com", edad: 25, nombre: "Ana"},
    %Usuario{email: "carlos.example.com", edad: 30, nombre: "Carlos"},
    %Usuario{email: "maria@example.com", edad: -5, nombre: "María"},
    %Usuario{email: "juan@example.com", edad: 40, nombre: ""},
    %Usuario{email: "sofia@example.com", edad: 19, nombre: "Sofía"},
    %Usuario{email: "pedro@correo.com", edad: 0, nombre: "Pedro"},
    %Usuario{email: "lucas@mail", edad: 22, nombre: "Lucas"},
    %Usuario{email: "laura@example.com", edad: 33, nombre: "Laura"},
    %Usuario{email: "lina@mail.com", edad: 26, nombre: "Lina"},
    %Usuario{email: "sebastian@correo.com", edad: -3, nombre: "Sebastián"},
    %Usuario{email: "patricia.example.com", edad: 41, nombre: "Patricia"},
    %Usuario{email: "jorge@example.com", edad: 33, nombre: ""},
    %Usuario{email: "veronica@mail", edad: 19, nombre: "Verónica"},
    %Usuario{email: "ricardo@example.com", edad: 0, nombre: "Ricardo"},
    %Usuario{email: "gabriela@correo.com", edad: 22, nombre: "Gabriela"},
    %Usuario{email: "oscar@", edad: 45, nombre: "Óscar"},
    %Usuario{email: "natalia@example.com", edad: -8, nombre: "Natalia"},
    %Usuario{email: "francisco@example.com", edad: 37, nombre: "Francisco"},
    %Usuario{email: "angela@dominio.com", edad: 18, nombre: "Ángela"},
    %Usuario{email: "miguel@@mail.com", edad: 50, nombre: "Miguel"},
    %Usuario{email: "diana@example.com", edad: 60, nombre: " "},
    %Usuario{email: "hernan@example.com", edad: 24, nombre: "Hernán"},
    %Usuario{email: "paula@mail.com", edad: 35, nombre: "Paula"},
    %Usuario{email: "diego.example.com", edad: 21, nombre: "Diego"},
    %Usuario{email: "catalina@example.com", edad: 40, nombre: ""},
    %Usuario{email: "ramiro@example.com", edad: -2, nombre: "Ramiro"},
    %Usuario{email: "camilo@correo.com", edad: 32, nombre: "Camilo"},
    %Usuario{email: "isabel@example.com", edad: 28, nombre: "Isabel"}
  ]
  end

  # Benchmark
  def run_benchmark(lista_usuarios) do
    tiempos1 =
      Benchmark.determinar_tiempo_ejecucion({__MODULE__, :validar_datos_secuencial, [lista_usuarios]})
    IO.puts("Tiempo de ejecución secuencial: #{tiempos1} microsegundos")

    tiempos2 =
      Benchmark.determinar_tiempo_ejecucion({__MODULE__, :validar_datos_concurrente, [lista_usuarios]})
    IO.puts("Tiempo de ejecución concurrente: #{tiempos2} microsegundos")

    Benchmark.calcular_speedup(tiempos2, tiempos1)
  end

    def iniciar do
    usuarios = lista_usuarios()

    validacion_datos1 = validar_datos_secuencial(usuarios)
    IO.puts("\n validación datos SECUENCIAL:")
    Enum.each(validacion_datos1, fn {email, valor} ->
      IO.puts("El email del usuario es: #{email}. ¿Sus datos son válidos?: #{inspect(valor)}")
    end)
    IO.puts("\n")

    validacion_datos2 = validar_datos_concurrente(usuarios)
    IO.puts("\n validación datos CONCURRENTE:")
    Enum.each(validacion_datos2, fn {email, valor} ->
      IO.puts("El email del usuario es: #{email}. ¿Sus datos son válidos?: #{inspect(valor)}")
    end)

    speed_up = run_benchmark(usuarios)
    IO.puts("\nSpeedup concurrente vs secuencial: #{speed_up}\n")

    IO.puts("\nSimulación terminada.\n")
  end
end

Validar.iniciar()
