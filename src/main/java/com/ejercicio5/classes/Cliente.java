/*
Autor: Gerardo Saz
Fecha: 27/4/2025
 */
package com.ejercicio5.classes;

import com.ejercicio5.interfaces.ITotalPago;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

public class Cliente implements ITotalPago {
    private int id;
    private String nombres;
    private String apellidos;
    private boolean vip;

    // Automotor del cliente
    private Automotor automotor;

    // Servicio del cliente
    private Servicio servicio;

    // Constructor sin id, id es opcional
    public Cliente(String nombres, String apellidos, boolean vip) {
        if (!validarNombres(nombres)) {
            throw new IllegalArgumentException("El nombre solo puede contener letras y espacios.");
        }
        if (!validarApellidos(apellidos)) {
            throw new IllegalArgumentException("El apellido solo puede contener letras y espacios.");
        }

        this.nombres = nombres;
        this.apellidos = apellidos;
        this.vip = vip;
    }

    // Constructor
    public Cliente(int id, String nombres, String apellidos, boolean vip) {
        if (!validarNombres(nombres)) {
            throw new IllegalArgumentException("El nombre solo puede contener letras y espacios.");
        }
        if (!validarApellidos(apellidos)) {
            throw new IllegalArgumentException("El apellido solo puede contener letras y espacios.");
        }

        this.id = id;
        this.nombres = nombres;
        this.apellidos = apellidos;
        this.vip = vip;
    }

    // Validación de nombres (solo letras y espacios)
    private boolean validarNombres(String nombres) {
        String regex = "^[a-zA-ZáéíóúÁÉÍÓÚñÑ\\s]+$";
        Pattern pattern = Pattern.compile(regex);
        Matcher matcher = pattern.matcher(nombres);
        return matcher.matches();
    }

    // Validación de apellidos (solo letras y espacios)
    private boolean validarApellidos(String apellidos) {
        String regex = "^[a-zA-ZáéíóúÁÉÍÓÚñÑ\\s]+$";
        Pattern pattern = Pattern.compile(regex);
        Matcher matcher = pattern.matcher(apellidos);
        return matcher.matches();
    }

    // Getters y setters
    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getNombres() {
        return nombres;
    }

    public void setNombres(String nombres) {
        if (!validarNombres(nombres)) {
            throw new IllegalArgumentException("El nombre solo puede contener letras y espacios.");
        }
        this.nombres = nombres;
    }

    public String getApellidos() {
        return apellidos;
    }

    public void setApellidos(String apellidos) {
        if (!validarApellidos(apellidos)) {
            throw new IllegalArgumentException("El apellido solo puede contener letras y espacios.");
        }
        this.apellidos = apellidos;
    }

    public boolean isVip() {
        return vip;
    }

    public void setVip(boolean vip) {
        this.vip = vip;
    }

    public Automotor getAutomotor() {
        return automotor;
    }

    public void setAutomotor(Automotor automotor) {
        if (automotor == null || !validarAutomotor(automotor)) {
            throw new IllegalArgumentException("El automóvil debe tener una marca, modelo y año válidos.");
        }
        this.automotor = automotor;
    }

    public Servicio getServicio() {
        return servicio;
    }

    public void setServicio(Servicio servicio) {
        this.servicio = servicio;
    }

    // Validación del automóvil
    private boolean validarAutomotor(Automotor automotor) {
        if (automotor.getMarca() == null || automotor.getMarca().isEmpty()) {
            return false;  // Marca vacía
        }
        if (automotor.getModelo() == null || automotor.getModelo().isEmpty()) {
            return false;  // Modelo vacío
        }
        int year = automotor.getYear();
        return year >= 1900 && year <= 2025;  // Validación de año
    }

    // Método para calcular el total de pago
    @Override
    public double totalPago() {
        // Verifica si el servicio está asignado
        if (this.servicio == null) {
            throw new IllegalStateException("El servicio no está asignado al cliente.");
        }

        double precioBase = servicio.getPrecio();
        return calcularDescuento(precioBase);
    }

    // Método para calcular el descuento
    private double calcularDescuento(double precioBase) {
        if (this.isVip()) {
            return precioBase * 0.85;  // Descuento del 15% para clientes VIP
        } else {
            return precioBase;  // Precio completo si no es VIP
        }
    }
}