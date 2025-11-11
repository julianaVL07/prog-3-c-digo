defmodule Validar do
  @moduledoc """
  Contexto: validar lotes de usuarios importados.
  Datos: %Usuario{email, edad, nombre}.
  Trabajo: validar(usuario) (correo con @, edad >= 0, nombre no vacío) + :timer.sleep(3..10).
  Secuencial: procesa usuarios en orden.
  Concurrente: un proceso por usuario.
  Salida: listado + speedup.
  """

  # --- Validación individual ---
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

    :timer.sleep(Enum.random(3..10))

    if errores == [] do
      {usuario.email, :ok}
    else
      {usuario.email, {:error, Enum.reverse(errores)}}
    end
  end

  # --- Validación secuencial ---
  def validar_datos_secuencial(usuarios) do
    Enum.map(usuarios, &validar_datos/1)
  end

  # --- Validación concurrente ---
  def validar_datos_concurrente(usuarios) do
    Enum.map(usuarios, fn usuario ->
      Task.async(fn -> validar_datos(usuario) end)
    end)
    |> Task.await_many()
  end

  # --- Lista base ---
  def lista_usuarios do
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
      %Usuario{email: "sebastian@correo.com", edad: -3, nombre: "Sebastián"}
    ]
  end

  # --- Benchmark ---
  def run_benchmark(usuarios) do
    tiempo_seq =
      Benchmark.determinar_tiempo_ejecucion({_MODULE_, :validar_datos_secuencial, [usuarios]})

    tiempo_con =
      Benchmark.determinar_tiempo_ejecucion({_MODULE_, :validar_datos_concurrente, [usuarios]})

    speedup = Benchmark.calcular_speedup(tiempo_con, tiempo_seq)
    speedup_redondeado = Float.round(speedup, 2)

    """
    Tiempo de ejecución secuencial: #{tiempo_seq} microsegundos.
    Tiempo de ejecución concurrente: #{tiempo_con} microsegundos.
    Speedup concurrente vs secuencial: #{speedup_redondeado}
    """
  end


  def iniciar do
    usuarios = lista_usuarios()
    resultados_seq = validar_datos_secuencial(usuarios)
    resultados_con = validar_datos_concurrente(usuarios)
    benchmark = run_benchmark(usuarios)

    """
    RESULTADOS DE VALIDACIÓN DE USUARIOS

    Validación SECUENCIAL:
    #{Enum.map_join(resultados_seq, "\n", fn {email, res} ->
      "  #{email} → #{inspect(res)}"
    end)}

    \nValidación CONCURRENTE:
    #{Enum.map_join(resultados_con, "\n", fn {email, res} ->
      "  #{email} → #{inspect(res)}"
    end)}

    \n#{benchmark}

    Simulación terminada en el servidor.
    """
  end
end
