package ejercicio2;

import java.time.LocalDate;  // Importa la clase LocalDate para trabajar con fechas.
import java.time.temporal.ChronoUnit;  // Importa ChronoUnit para trabajar con unidades de tiempo (como años).

// Clase que representa a una persona para el cálculo de vacaciones.
public class Persona {
    private String nombre;  // Atributo para almacenar el nombre de la persona.
    private double salario;  // Atributo para almacenar el salario de la persona.
    private LocalDate fechaIngreso;  // Atributo para almacenar la fecha de ingreso de la persona.

    // Constructor de la clase Persona que inicializa los atributos.
    public Persona(String nombre, double salario, LocalDate fechaIngreso) {
        this.nombre = nombre;  // Inicializa el nombre con el valor recibido como argumento.
        this.salario = salario;  // Inicializa el salario con el valor recibido como argumento.
        this.fechaIngreso = fechaIngreso;  // Inicializa la fecha de ingreso con el valor recibido como argumento.
    }

    // Método para obtener el nombre de la persona.
    public String getNombre() {
        return nombre;  // Retorna el nombre de la persona.
    }

    // Método para obtener el salario de la persona.
    public double getSalario() {
        return salario;  // Retorna el salario de la persona.
    }

    // Método para obtener la fecha de ingreso de la persona.
    public LocalDate getFechaIngreso() {
        return fechaIngreso;  // Retorna la fecha de ingreso de la persona.
    }

    // Método para calcular los días de vacaciones de la persona basado en su antigüedad.
    public int calcularVacaciones() {
        // Calcula la diferencia en años entre la fecha de ingreso y la fecha actual.
        long años = ChronoUnit.YEARS.between(fechaIngreso, LocalDate.now());

        // Lógica para determinar los días de vacaciones basados en los años de antigüedad.
        if (años >= 1 && años < 3) return 10;  // Si tiene entre 1 y 3 años de antigüedad, recibe 10 días de vacaciones.
        else if (años >= 3 && años <= 5) return 15;  // Si tiene entre 3 y 5 años de antigüedad, recibe 15 días de vacaciones.
        else if (años > 5) return 21;  // Si tiene más de 5 años de antigüedad, recibe 21 días de vacaciones.
        else return 0;  // Si tiene menos de 1 año de antigüedad, no tiene vacaciones.
    }
}