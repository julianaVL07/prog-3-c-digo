defmodule PrecioFinal do
  @moduledoc"""
  Contexto: calcular precio final por producto.
  Datos: %Producto{nombre, stock, precio_sin_iva, iva}.
  Trabajo: precio_final(p) = p.precio_sin_iva * (1 + p.iva).
  Secuencial vs Concurrente: sobre lista grande (p. ej. 50k productos).
  Salida: lista de {nombre, precio_final}; speedup.
  """

  # Función que calcula el precio final de un producto
  def precio_final(producto) do
    producto.precio_sin_iva * (1 + producto.iva)
  end

   # procesa los productos de forma secuencial
  def precios_finales_secuencial(productos) do
    Enum.map(productos, fn producto ->
      {producto.nombre, precio_final(producto)}
    end)
  end

   # procesa los productos de forma concurrente
  def precios_finales_concurrente(productos) do
    Enum.map(productos, fn producto ->
      Task.async(fn -> {producto.nombre, precio_final(producto)} end)
    end)
    |> Task.await_many()
  end

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

  # Benchmark
  def run_benchmark(lista_productos) do
    tiempos1 =
      Benchmark.determinar_tiempo_ejecucion({__MODULE__, :precios_finales_secuencial, [lista_productos]})
    IO.puts("Tiempo de ejecución secuencial: #{tiempos1} microsegundos")

    tiempos2 =
      Benchmark.determinar_tiempo_ejecucion({__MODULE__, :precios_finales_concurrente, [lista_productos]})
    IO.puts("Tiempo de ejecución concurrente: #{tiempos2} microsegundos")

    Benchmark.calcular_speedup(tiempos2, tiempos1)
  end


 def iniciar do
  productos = lista_productos()

  # Secuencial
  precios1 = precios_finales_secuencial(productos)
  IO.puts("\nPrecios finales (Secuencial):")
  Enum.each(precios1, fn {nombre, precio} ->
    IO.puts("  #{nombre} - $#{precio}")
  end)

  IO.puts("\n")

  # Concurrente
  precios2 = precios_finales_concurrente(productos)
  IO.puts("\nPrecios finales (Concurrente):")
  Enum.each(precios2, fn {nombre, precio} ->
    IO.puts("  #{nombre} - $#{precio}")
  end)

  speed_up = run_benchmark(productos)
  IO.puts("\nSpeedup concurrente vs secuencial: #{speed_up}\n")

  IO.puts("\nSimulación terminada.\n")
end
end

PrecioFinal.iniciar()
