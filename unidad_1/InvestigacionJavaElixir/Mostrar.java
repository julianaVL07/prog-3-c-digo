package InvestigacionJavaElixir;

import javax.swing.JOptionPane;

public class Mostrar {
    public static void main(String[] args) {
         // Verifica si se recibió al menos un argumento desde Elixir
        if (args.length > 0) {
             // Si hay argumento, muestra un saludo personalizado en un cuadro de diálogo
            JOptionPane.showMessageDialog(null, "Hola " + args[0] + ", bienvenid@!");
        } else {
              // Si no se recibió ningún dato, muestra un mensaje de advertencia
            JOptionPane.showMessageDialog(null, "No se recibió ningún dato");
        }
    }
}