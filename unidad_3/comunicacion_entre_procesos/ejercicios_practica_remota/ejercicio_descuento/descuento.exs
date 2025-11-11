defmodule Descuento do
  @moduledoc """
  Contexto: aplicar reglas de descuentos (cupón, % por categoría, 2x1).
  Datos: %Carrito{id, items, cupon}.
  Trabajo: total_con_descuentos/1 evalúa reglas + :timer.sleep(5..15).
  Secuencial vs Concurrente: por carrito.
  Salida: {id, total_final}; speedup.
  """

  defmodule Carrito do
    defstruct [:id, :items, :cupon]
  end

  # Cálculo individual
  def total_con_descuentos(carrito) do
    total = Enum.reduce(carrito.items, 0, fn item, acc -> acc + item.precio end)

    total_final =
      case carrito.cupon do
        "DESC10" -> total * 0.9
        "VIP20" -> total * 0.8
        _ -> total
      end

    :timer.sleep(Enum.random(5..15))
    {carrito.id, total_final |> round()}
  end

  # Procesamiento secuencial
  def total_con_descuentos_secuencial(carritos) do
    Enum.map(carritos, &total_con_descuentos/1)
  end

  # Procesamiento concurrente
  def total_con_descuentos_concurrente(carritos) do
    Enum.map(carritos, fn carrito ->
      Task.async(fn -> total_con_descuentos(carrito) end)
    end)
    |> Task.await_many()
  end

  # Lista base
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

  # Benchmark helpers
  defmodule Benchmark do
    def determinar_tiempo_ejecucion({mod, fun, args}) do
      {tiempo, _res} = :timer.tc(mod, fun, args)
      tiempo
    end

    def calcular_speedup(tiempo_con, tiempo_seq) do
      Float.round(tiempo_seq / tiempo_con, 2)
    end
  end

  #  Versión corregida del benchmark
  def run_benchmark(lista_carritos) do
    t_seq =
      Benchmark.determinar_tiempo_ejecucion(
        {_MODULE_, :total_con_descuentos_secuencial, [lista_carritos]}
      )

    t_con =
      Benchmark.determinar_tiempo_ejecucion(
        {_MODULE_, :total_con_descuentos_concurrente, [lista_carritos]}
      )

    speedup = Benchmark.calcular_speedup(t_con, t_seq)

    """
    Tiempo de ejecución secuencial: #{t_seq} microsegundos.
    Tiempo de ejecución concurrente: #{t_con} microsegundos.
    Speedup concurrente vs secuencial: #{speedup}
    """
  end

  # Ejecución principal (devuelve texto)
  def iniciar do
    carritos = lista_carritos()
    total1 = total_con_descuentos_secuencial(carritos)
    total2 = total_con_descuentos_concurrente(carritos)
    benchmark = run_benchmark(carritos)

    """
    RESULTADOS DE DESCUENTOS

    Secuencial:
    #{Enum.map_join(total1, "\n", fn {id, total} ->
      "  Carrito #{id}: $#{total}"
    end)}

    \nConcurrente:
    #{Enum.map_join(total2, "\n", fn {id, total} ->
      "  Carrito #{id}: $#{total}"
    end)}

    \n#{benchmark}

    Simulación terminada en el servidor.
    """
  end
end
