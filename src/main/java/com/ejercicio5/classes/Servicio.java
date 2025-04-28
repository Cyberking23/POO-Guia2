/*
Autor: Gerardo Saz
Fecha: 27/4/2025
 */

package com.ejercicio5.classes;
import java.sql.Timestamp;

public class Servicio {
    private int id;
    private int clienteId;
    private String tipo;
    private double precio;

    // Constructor
    public Servicio() {
    }

    public Servicio(int clienteId, String tipo, double precio) {
        this.clienteId = clienteId;
        this.tipo = tipo;
        this.precio = precio;
    }

    public Servicio(int id, int clienteId, String tipo, double precio) {
        this.id = id;
        this.clienteId = clienteId;
        this.tipo = tipo;
        this.precio = precio;
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
        this.clienteId = clienteId;
    }


    public String getTipo() {
        return tipo;
    }

    public void setTipo(String tipo) {
        this.tipo = tipo;
    }

    public double getPrecio() {
        return precio;
    }

    public void setPrecio(double precio) {
        this.precio = precio;
    }
}
