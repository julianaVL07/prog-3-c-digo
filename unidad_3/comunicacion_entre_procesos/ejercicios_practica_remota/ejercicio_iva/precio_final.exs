defmodule PrecioFinal do
  @moduledoc """
  Contexto: calcular precio final por producto.
  Datos: %Producto{nombre, stock, precio_sin_iva, iva}.
  Trabajo: precio_final(p) = p.precio_sin_iva * (1 + p.iva).
  Secuencial vs Concurrente: sobre lista grande (p. ej. 50k productos).
  Salida: lista de {nombre, precio_final}; speedup.
  """

  defmodule Producto do
    defstruct [:nombre, :stock, :precio_sin_iva, :iva]
  end

  # Cálculo individual
  def precio_final(producto) do
    producto.precio_sin_iva * (1 + producto.iva)
  end

  # Procesamiento secuencial
  def precios_finales_secuencial(productos) do
    Enum.map(productos, fn producto ->
      {producto.nombre, precio_final(producto)}
    end)
  end

  # Procesamiento concurrente
  def precios_finales_concurrente(productos) do
    Enum.map(productos, fn producto ->
      Task.async(fn -> {producto.nombre, precio_final(producto)} end)
    end)
    |> Task.await_many()
  end

  # Lista base
  def lista_productos do
    [
      %Producto{nombre: "Televisor", stock: 20, precio_sin_iva: 1200.0, iva: 0.19},
      %Producto{nombre: "Computador", stock: 15, precio_sin_iva: 2500.0, iva: 0.19},
      %Producto{nombre: "Celular", stock: 30, precio_sin_iva: 1800.0, iva: 0.19},
      %Producto{nombre: "Tablet", stock: 25, precio_sin_iva: 900.0, iva: 0.19},
      %Producto{nombre: "Impresora", stock: 10, precio_sin_iva: 600.0, iva: 0.19},
      %Producto{nombre: "Mouse", stock: 50, precio_sin_iva: 80.0, iva: 0.19},
      %Producto{nombre: "Teclado", stock: 40, precio_sin_iva: 100.0, iva: 0.19},
      %Producto{nombre: "Monitor", stock: 18, precio_sin_iva: 950.0, iva: 0.19},
      %Producto{nombre: "Parlantes", stock: 22, precio_sin_iva: 400.0, iva: 0.19},
      %Producto{nombre: "Cámara", stock: 12, precio_sin_iva: 1500.0, iva: 0.19},
      %Producto{nombre: "Smartwatch", stock: 28, precio_sin_iva: 700.0, iva: 0.19},
      %Producto{nombre: "Router", stock: 16, precio_sin_iva: 350.0, iva: 0.19},
      %Producto{nombre: "Disco Duro", stock: 35, precio_sin_iva: 450.0, iva: 0.19},
      %Producto{nombre: "Memoria USB", stock: 60, precio_sin_iva: 50.0, iva: 0.19},
      %Producto{nombre: "Consola", stock: 8, precio_sin_iva: 2800.0, iva: 0.19}
    ]
  end

  # --- Benchmark helpers ---
  defmodule Benchmark do
    def determinar_tiempo_ejecucion({mod, fun, args}) do
      {tiempo, _res} = :timer.tc(mod, fun, args)
      tiempo
    end

    def calcular_speedup(tiempo_con, tiempo_seq) do
      Float.round(tiempo_seq / tiempo_con, 2)
    end
  end

  # --- Benchmark principal ---
  def run_benchmark(lista_productos) do
    tiempo_seq =
      Benchmark.determinar_tiempo_ejecucion({_MODULE_, :precios_finales_secuencial, [lista_productos]})

    tiempo_con =
      Benchmark.determinar_tiempo_ejecucion({_MODULE_, :precios_finales_concurrente, [lista_productos]})

    speedup = Benchmark.calcular_speedup(tiempo_con, tiempo_seq)

    {tiempo_seq, tiempo_con, speedup}
  end

  # --- Ejecución principal ---
  def iniciar do
    productos = lista_productos()
    precios1 = precios_finales_secuencial(productos)
    precios2 = precios_finales_concurrente(productos)
    {tiempo_seq, tiempo_con, speedup} = run_benchmark(productos)

    """
    RESULTADOS DE PRECIO FINAL

    Secuencial:
    #{Enum.map_join(precios1, "\n", fn {nombre, precio} ->
      "  #{nombre}: $#{precio}"
    end)}

    \nConcurrente:
    #{Enum.map_join(precios2, "\n", fn {nombre, precio} ->
      "  #{nombre}: $#{precio}"
    end)}

    \nTiempo de ejecución secuencial: #{tiempo_seq} microsegundos.
    Tiempo de ejecución concurrente: #{tiempo_con} microsegundos.
    Speedup concurrente vs secuencial: #{speedup}
    """
  end
end
