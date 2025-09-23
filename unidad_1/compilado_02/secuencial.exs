defmodule Test do
  def run_tests do
    Util.mostrar_mensaje("Teststing Util module")
  end

  def pedir_informacion do
    Util.pedir_informacion()
  end

end

Test.run_tests()
Test.pedir_informacion()
