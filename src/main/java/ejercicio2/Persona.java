package ejercicio2;

import java.time.LocalDate;  // Importa la clase LocalDate para trabajar con fechas.
import java.time.temporal.ChronoUnit;  // Importa ChronoUnit para trabajar con unidades de tiempo (como años).

// Clase que representa a una persona para el cálculo de vacaciones.
public class Persona {
    private String nombre;
    private double salario;
    private LocalDate fechaIngreso;

    // Constructor de la clase Persona que inicializa los atributos.
    public Persona(String nombre, double salario, LocalDate fechaIngreso) {
        this.nombre = nombre;
        this.salario = salario;
        this.fechaIngreso = fechaIngreso;
    }

    // Método para obtener el nombre de la persona.
    public String getNombre() {
        return nombre;
    }

    // Método para obtener el salario de la persona.
    public double getSalario() {
        return salario;
    }

    // Método para obtener la fecha de ingreso de la persona.
    public LocalDate getFechaIngreso() {
        return fechaIngreso;
    }

    // Método para calcular los días de vacaciones de la persona basado en su antigüedad.
    public int calcularVacaciones() {
        long años = ChronoUnit.YEARS.between(fechaIngreso, LocalDate.now());

        if (años >= 1 && años < 3) return 10;
        else if (años >= 3 && años <= 5) return 15;
        else if (años > 5) return 21;
        else return 0;
    }
}