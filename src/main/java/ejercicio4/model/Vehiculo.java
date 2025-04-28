/*Autor Joaquin Fuentes
Fecha: Abril 2025*/
package ejercicio4.model;


/**
 * Clase que representa un vehículo vendido por la importadora
 */
public class Vehiculo {
    // Atributo para almacenar el nombre del cliente que compró el vehículo.
    private String nombreCliente;
    // Atributo para almacenar el sexo del cliente.
    private String sexoCliente;
    // Atributo para almacenar la marca del vehículo.
    private String marca;
    // Atributo para almacenar el año de fabricación del vehículo.
    private int año;
    // Atributo para almacenar el precio de venta del vehículo.
    private double precio;

    // Constructor de la clase Vehiculo. Se utiliza para crear objetos Vehiculo inicializando sus atributos.
    public Vehiculo(String nombreCliente, String sexoCliente, String marca, int año, double precio) {
        this.nombreCliente = nombreCliente;
        this.sexoCliente = sexoCliente;
        this.marca = marca;
        this.año = año;
        this.precio = precio;
    }

    // Getter para obtener el nombre del cliente.
    public String getNombreCliente() {
        return nombreCliente;
    }

    // Setter para establecer el nombre del cliente.
    public void setNombreCliente(String nombreCliente) {
        this.nombreCliente = nombreCliente;
    }

    // Getter para obtener el sexo del cliente.
    public String getSexoCliente() {
        return sexoCliente;
    }

    // Setter para establecer el sexo del cliente.
    public void setSexoCliente(String sexoCliente) {
        this.sexoCliente = sexoCliente;
    }

    // Getter para obtener la marca del vehículo.
    public String getMarca() {
        return marca;
    }

    // Setter para establecer la marca del vehículo.
    public void setMarca(String marca) {
        this.marca = marca;
    }

    // Getter para obtener el año del vehículo.
    public int getAño() {
        return año;
    }

    // Setter para establecer el año del vehículo.
    public void setAño(int año) {
        this.año = año;
    }

    // Getter para obtener el precio del vehículo.
    public double getPrecio() {
        return precio;
    }

    // Setter para establecer el precio del vehículo.
    public void setPrecio(double precio) {
        this.precio = precio;
    }
}