defmodule Descuento do
    @moduledoc"""
    Contexto: aplicar reglas de descuentos (cupón, % por categoría, 2x1).
    Datos: %Carrito{id, items, cupon}.
    Trabajo: total_con_descuentos/1 evalúa reglas + :timer.sleep(5..15).
    Secuencial vs Concurrente: por carrito.
    Salida: {id, total_final}; speedup.
    """


  def total_con_descuentos(carrito)do
    total_descuentos=
    if carrito.cupon == nil do
        0
    else
        carrito.items
        |> Enum.map(fn item -> item.precio * 0.10 end)
        |> Enum.sum()
    end

    :timer.sleep(Enum.random(5..15))
    {carrito.id, total_descuentos}
  end

    def total_con_descuentos2(carrito) do
        # Calculamos el total sin descuento
        total = Enum.reduce(carrito.items, 0, fn item, acc -> acc + item.precio end)

        # Aplicamos descuento según el cupón
        total_final =
        case carrito.cupon do
            "DESC10" -> total * 0.9   # 10% de descuento
            "VIP20"  -> total * 0.8   # 20% de descuento
            _        -> total         # Sin cupón o cupón no válido
        end

        # Simula tiempo de procesamiento
        :timer.sleep(Enum.random(5..15))

        {carrito.id, total_final |> Float.round(2)}
    end

  def total_con_descuentos_secuencial(carritos) do
    Enum.map(carritos, fn carrito -> total_con_descuentos(carrito) end)
  end

  def total_con_descuentos_concurrente(carritos) do
    Enum.map(carritos, fn carrito ->
      Task.async(fn -> total_con_descuentos(carrito) end)
    end)
    |> Task.await_many()
  end

  def lista_carritos do
  [
    %Carrito{
      id: 1,
      cupon: "DESC10",
      items: [
        %{nombre: "Camiseta", precio: 50000},
        %{nombre: "Pantalón", precio: 80000}
      ]
    },
    %Carrito{
      id: 2,
      cupon: nil,
      items: [
        %{nombre: "Gaseosa", precio: 4000},
        %{nombre: "Agua", precio: 3000}
      ]
    },
    %Carrito{
      id: 3,
      cupon: "VIP20",
      items: [
        %{nombre: "Perfume", precio: 120000},
        %{nombre: "Crema", precio: 60000}
      ]
    },
    %Carrito{
      id: 4,
      cupon: "DESC10",
      items: [
        %{nombre: "Reloj", precio: 90000},
        %{nombre: "Camisa", precio: 70000}
      ]
    }
  ]
end

# Benchmark
  def run_benchmark(lista_carritos) do
    tiempos1 =
      Benchmark.determinar_tiempo_ejecucion({__MODULE__, :total_con_descuentos_secuencial, [lista_carritos]})
    IO.puts("Tiempo de ejecución secuencial: #{tiempos1} microsegundos")

    tiempos2 =
      Benchmark.determinar_tiempo_ejecucion({__MODULE__, :total_con_descuentos_concurrente, [lista_carritos]})
    IO.puts("Tiempo de ejecución concurrente: #{tiempos2} microsegundos")

    Benchmark.calcular_speedup(tiempos2, tiempos1)
  end

  def iniciar do
    carritos = lista_carritos()

    total1 = total_con_descuentos_secuencial(carritos)
    IO.puts("\nTotal con descuentos SECUENCIAL:")
    Enum.each(total1, fn {id, total_descuento} ->
      IO.puts("carrito #{id} - Total descuento aplicado: #{trunc(total_descuento)}")
    end)
    IO.puts("\n")

    total2 = total_con_descuentos_concurrente(carritos)
    IO.puts("\nTotal con descuentos CONCURRENTE:")
    Enum.each(total2, fn {id, total_descuento} ->
      IO.puts("carrito #{id} - Total descuento aplicado: #{trunc(total_descuento)}")
    end)

    speed_up = run_benchmark(carritos)
    IO.puts("\nSpeedup concurrente vs secuencial: #{speed_up}\n")

    IO.puts("\nSimulación terminada.\n")
  end
end
Descuento.iniciar()
