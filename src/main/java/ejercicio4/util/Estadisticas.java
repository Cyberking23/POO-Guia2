/*Autor Joaquin Fuentes
Fecha: Abril 2025*/
package ejercicio4.util;
import ejercicio4.model.Vehiculo;
import java.util.List;

/**
 * Clase para calcular estadísticas de los vehículos vendidos
 */
public class Estadisticas {
    /**
     * Calcula el total de vehículos vendidos de una marca específica y la suma total de sus precios de venta.
     * @param vehiculos La lista de objetos Vehiculo sobre la cual se realizarán los cálculos.
     * @param marca La marca de vehículos que se utilizará como filtro para el cálculo.
     * @return Un arreglo de tipo double con dos elementos: el primero indica la cantidad de vehículos de la marca especificada,
     * y el segundo indica la suma total de los precios de venta de esos vehículos.
     */
    public static double[] calcularTotalPorMarca(List<Vehiculo> vehiculos, String marca) {
        // Inicializa un contador para la cantidad de vehículos de la marca especificada.
        int cantidad = 0;
        // Inicializa una variable para almacenar la suma total de los precios de los vehículos de la marca especificada.
        double sumaTotal = 0;

        // Itera sobre cada objeto Vehiculo en la lista proporcionada.
        for (Vehiculo v : vehiculos) {
            // Comprueba si la marca del vehículo actual (ignorando mayúsculas y minúsculas) coincide con la marca especificada.
            if (v.getMarca().equalsIgnoreCase(marca)) {
                // Si la marca coincide, incrementa el contador de cantidad.
                cantidad++;
                // Y añade el precio del vehículo a la suma total.
                sumaTotal += v.getPrecio();
            }
        }

        // Retorna un nuevo arreglo de doubles conteniendo la cantidad de vehículos de la marca y la suma total de sus precios.
        return new double[]{cantidad, sumaTotal};
    }

    /**
     * Calcula la cantidad de vehículos vendidos dentro de un rango específico de años.
     * @param vehiculos La lista de objetos Vehiculo a analizar.
     * @param añoInicio El año de inicio del rango (inclusive).
     * @param añoFin El año de fin del rango (inclusive).
     * @return La cantidad de vehículos cuya propiedad 'año' se encuentra dentro del rango especificado.
     */
    public static int calcularPorRangoAños(List<Vehiculo> vehiculos, int añoInicio, int añoFin) {
        // Inicializa un contador para la cantidad de vehículos dentro del rango de años.
        int cantidad = 0;

        // Itera a través de cada vehículo en la lista.
        for (Vehiculo v : vehiculos) {
            // Comprueba si el año del vehículo actual es mayor o igual al año de inicio Y menor o igual al año de fin.
            if (v.getAño() >= añoInicio && v.getAño() <= añoFin) {
                // Si el año está dentro del rango, incrementa el contador.
                cantidad++;
            }
        }

        // Retorna la cantidad total de vehículos que se encuentran dentro del rango de años especificado.
        return cantidad;
    }
}
