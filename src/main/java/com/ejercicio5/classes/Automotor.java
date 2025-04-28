/*
Autor: Gerardo Saz
Fecha: 27/4/2025
 */
package com.ejercicio5.classes;
import java.util.regex.Pattern;

public class Automotor {
    private int id;
    private int clienteId;
    private String marca;
    private String modelo;
    private int year;

    // Expresiones regulares para validación
    private static final String MARCA_MODELO_REGEX = "^[a-zA-Z\\s]+$";  // Solo letras y espacios
    private static final int MIN_YEAR = 1900;
    private static final int MAX_YEAR = 2025;

    public Automotor(int clienteId, String marca, String modelo, int year) {
        if (!isValidClienteId(clienteId)) {
            throw new IllegalArgumentException("ID de cliente no válido");
        }
        if (!isValidMarca(marca)) {
            throw new IllegalArgumentException("Marca no válida");
        }
        if (!isValidModelo(modelo)) {
            throw new IllegalArgumentException("Modelo no válido");
        }
        if (!isValidYear(year)) {
            throw new IllegalArgumentException("Año no válido");
        }

        this.clienteId = clienteId;
        this.marca = marca;
        this.modelo = modelo;
        this.year = year;
    }

    public Automotor(int id, int clienteId, String marca, String modelo, int year) {
        if (!isValidClienteId(clienteId)) {
            throw new IllegalArgumentException("ID de cliente no válido");
        }
        if (!isValidMarca(marca)) {
            throw new IllegalArgumentException("Marca no válida");
        }
        if (!isValidModelo(modelo)) {
            throw new IllegalArgumentException("Modelo no válido");
        }
        if (!isValidYear(year)) {
            throw new IllegalArgumentException("Año no válido");
        }

        this.id = id;
        this.clienteId = clienteId;
        this.marca = marca;
        this.modelo = modelo;
        this.year = year;
    }

    // Validaciones
    private boolean isValidClienteId(int clienteId) {
        // Aquí se valida si el ID del cliente es positivo
        return clienteId > 0;
    }

    private boolean isValidMarca(String marca) {
        // Validar que la marca solo contenga letras y espacios
        return marca != null && Pattern.matches(MARCA_MODELO_REGEX, marca.trim());
    }

    private boolean isValidModelo(String modelo) {
        // Validar que el modelo solo contenga letras y espacios
        return modelo != null && Pattern.matches(MARCA_MODELO_REGEX, modelo.trim());
    }

    private boolean isValidYear(int year) {
        // Validar que el año esté en un rango razonable
        return year >= MIN_YEAR && year <= MAX_YEAR;
    }

    // Getters y setters
    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public int getClienteId() {
        return clienteId;
    }

    public void setClienteId(int clienteId) {
        if (!isValidClienteId(clienteId)) {
            throw new IllegalArgumentException("ID de cliente no válido");
        }
        this.clienteId = clienteId;
    }

    public String getMarca() {
        return marca;
    }

    public void setMarca(String marca) {
        if (!isValidMarca(marca)) {
            throw new IllegalArgumentException("Marca no válida");
        }
        this.marca = marca;
    }

    public String getModelo() {
        return modelo;
    }

    public void setModelo(String modelo) {
        if (!isValidModelo(modelo)) {
            throw new IllegalArgumentException("Modelo no válido");
        }
        this.modelo = modelo;
    }

    public int getYear() {
        return year;
    }

    public void setYear(int year) {
        if (!isValidYear(year)) {
            throw new IllegalArgumentException("Año no válido");
        }
        this.year = year;
    }
}
