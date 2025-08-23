package InvestigacionJavaElixir;

import javax.swing.JOptionPane;

public class Generar {
    public static void main(String[] args) {
        // Muestra un cuadro de diálogo para que el usuario ingrese su nombre
        String nombre = JOptionPane.showInputDialog("Ingrese su nombre:");
        // Imprime el nombre en consola (stdout), de donde lo captura Elixir
        System.out.println(nombre); // aquí lo captura Elixir
    }
}